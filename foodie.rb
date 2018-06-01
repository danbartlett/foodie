require 'sequel'
require 'csv'
require 'pry'
require 'terminal-table'

class Numeric
  def fraction_of(n)
    self.to_f / n.to_f
  end
end

DB = Sequel.sqlite # memory database, requires sqlite3

DB.create_table :ingredients do
  primary_key :id
  String :name
  String :brand
  String :product_link
  Integer :weight
  Integer :calories
  Float :carbohydrate
  Float :sugar
  Float :fat
  Float :protein
  Float :fibre
end

class Ingredient < Sequel::Model
  def validate
    super
    errors.add(:carbohydrate, "can't be empty") if carbohydrate.nil?
    errors.add(:sugar, "can't be empty") if sugar.nil?
    errors.add(:fibre, "can't be empty") if fibre.nil?
  end

  def macros
    rows = []
    rows << ['Carbs', "#{carbohydrate_percentage.round}%"]
    rows << ['Sugar', "#{sugar_percentage.round}%"]
    rows << ['Fat', "#{fat_percentage.round}%"]
    rows << ['Protein', "#{protein_percentage.round}%"]
    rows << ['Fibre', "#{fibre_percentage.round}%"]
    Terminal::Table.new rows: rows, title: self.name
  end

  def protein_percentage
    self.protein * 4 / self.calories * 100
  end

  def carbohydrate_percentage
    self.carbohydrate * 4 / self.calories * 100
  end

  def sugar_percentage
    self.sugar * 4 / self.calories * 100
  end

  def fat_percentage
    self.fat * 9 / self.calories * 100
  end

  def fibre_percentage
    self.fibre * 9 / self.calories * 100
  end
end

class IngredientQuantity
  attr_reader :amount, :ingredient

  def initialize(ingredient:, amount:)
    @ingredient = ingredient
    @amount = amount

    if amount && amount != ingredient.weight
      @multiplier = amount.to_i.fraction_of ingredient.weight
    end
  end

  def calories
    @ingredient.calories * @multiplier
  end

  def carbohydrate
    @ingredient.carbohydrate * @multiplier
  end

  def sugar
    @ingredient.sugar * @multiplier
  end

  def fat
    @ingredient.fat * @multiplier
  end

  def fibre
    @ingredient.fibre * @multiplier
  end

  def protein
    @ingredient.protein * @multiplier
  end

  def summary
    rows = []
    rows << ['Calories', "#{calories} kcal"]
    rows << ['Carbs', "#{carbohydrate}g"]
    rows << ['Sugar', "#{sugar}g"]
    rows << ['Fat', "#{fat}g"]
    rows << ['Protein', "#{protein}g"]
    rows << ['Fibre', "#{fibre}g"]
    Terminal::Table.new rows: rows, title: "#{@amount}g of #{@ingredient.name}"
  end
end

class Meal
  def initialize(*ingredients)
    @all_ingredients = []
    ingredients.each do |ingredient|
      name, amount = ingredient.split(',')
      ingredient_model = Ingredient.first(Sequel.like(:name, "#{name}%"))
      @all_ingredients << ingredient_model
      amount_in_db = ingredient_model.weight
      amount_we_want = amount.to_i

      # Calculate ratio of quantity specified, to the quantity we have saved in
      # the database
      difference = amount_we_want.fraction_of amount_in_db
    end
  end

  def calories
    @all_ingredients.map(&:calories).sum
  end

  def carbohydrate
    @all_ingredients.map(&:carbohydrate).sum
  end

  def sugar
    @all_ingredients.map(&:sugar).sum
  end

  def fat
    @all_ingredients.map(&:fat).sum
  end

  def fibre
    @all_ingredients.map(&:fibre).sum
  end

  def protein
    @all_ingredients.map(&:protein).sum
  end

  def summary
    rows = []
    rows << ['Calories', "#{calories} kcal"]
    rows << ['Carbs', "#{carbohydrate_percentage.round}%"]
    rows << ['Sugar', "#{sugar_percentage.round}%"]
    rows << ['Fat', "#{fat_percentage.round}%"]
    rows << ['Protein', "#{protein_percentage.round}%"]
    rows << ['Fibre', "#{fibre_percentage.round}%"]
    Terminal::Table.new rows: rows, title: self.name
  end
end

# Load all ingredients from CSV
CSV.foreach("database.csv", headers: true) do |row|
  Ingredient.create(
    name: row[0],
    brand: row[1],
    weight: row[2],
    calories: row[3],
    protein: row[4],
    carbohydrate: row[5],
    sugar: row[6],
    fat: row[7],
    fibre: row[8],
    product_link: row[9]
  )
end

Ingredient.all.each do |ingredient|
  puts ingredient.macros; puts
end
