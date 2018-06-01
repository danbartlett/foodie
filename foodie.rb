require 'sequel'
require 'csv'
require 'pry'
require 'terminal-table'

class IngredientNotFound < StandardError; end

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
  Integer :amount
  String :unit
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

    if amount && amount != ingredient.amount
      @multiplier = amount.to_i.fraction_of ingredient.amount
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
    Terminal::Table.new rows: rows, title: "#{@amount} #{@ingredient.unit} of #{@ingredient.name}"
  end
end

class Meal
  attr_reader :name

  def initialize(name:, ingredients:)
    @all_ingredients = []
    @name = name

    ingredients.each do |ingredient|
      name, amount = ingredient.split(',')
      ingredient_model = Ingredient.first(Sequel.like(:name, "#{name}%"))
      raise IngredientNotFound, "#{name} not found!" unless ingredient_model

      @all_ingredients << IngredientQuantity.new(ingredient: ingredient_model, amount: amount)
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

  def summary
    @all_ingredients.each do |quantity|
      puts "#{quantity.amount} #{quantity.ingredient.unit} of #{quantity.ingredient.name}: #{quantity.calories} cals"
      puts quantity.summary; puts
    end
    puts

    rows = []
    rows << ['Calories', "#{calories} kcal"]
    rows << ['Carbs', "#{carbohydrate}g", "#{carbohydrate_percentage.round}%"]
    rows << ['Sugar', "#{sugar}g", "#{sugar_percentage.round}%"]
    rows << ['Fat', "#{fat}g", "#{fat_percentage.round}%"]
    rows << ['Protein', "#{protein}g", "#{protein_percentage.round}%"]
    rows << ['Fibre', "#{fibre}g", "#{fibre_percentage.round}%"]
    Terminal::Table.new rows: rows, title: name
  end
end

class Day
  def initialize(*meals)
    @all_meals = meals
  end

  def calories
    @all_meals.map(&:calories).sum
  end

  def carbohydrate
    @all_meals.map(&:carbohydrate).sum
  end

  def sugar
    @all_meals.map(&:sugar).sum
  end

  def fat
    @all_meals.map(&:fat).sum
  end

  def fibre
    @all_meals.map(&:fibre).sum
  end

  def protein
    @all_meals.map(&:protein).sum
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

  def summary
    summary_table = Terminal::Table.new(title: "Meals for #{Time.now.strftime("%A, %b %d %Y")}", headings: ['Name', 'Calories', 'Carbs', 'Sugar', 'Fat', 'Protein', 'Fibre']) do |t|
      @all_meals.each do |meal|
        t.add_row [meal.name, meal.calories.round, "#{meal.carbohydrate.round}g", "#{meal.sugar.round}g", "#{meal.fat}g", "#{meal.protein}g", "#{meal.fibre}g"]
      end
      t.add_separator
      t.add_row ['TOTALS', calories.round, "#{carbohydrate.round}g", "#{sugar.round}g", "#{fat.round}g", "#{protein.round}g", "#{fibre.round}g"]
      t.add_separator
      t.add_row ["MACRO %s", '-', "#{carbohydrate_percentage.round}%", "#{sugar_percentage.round}%", "#{fat_percentage.round}%", "#{protein_percentage.round}%", "#{fibre_percentage.round}%"]
    end

    summary_table
  end
end

# Load all ingredients from CSV
CSV.foreach("database.csv", headers: true) do |row|
  Ingredient.create(
    name: row[0],
    brand: row[1],
    amount: row[2],
    unit: row[3],
    calories: row[4],
    protein: row[5],
    carbohydrate: row[6],
    sugar: row[7],
    fat: row[8],
    fibre: row[9],
    product_link: row[10]
  )
end

Ingredient.all.each do |ingredient|
  puts ingredient.macros; puts
end
