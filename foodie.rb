require 'sequel'
require 'csv'
require 'pry'
require 'terminal-table'

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

require_relative './models/ingredient.rb'
require_relative './models/quantity.rb'

class IngredientNotFound < StandardError; end

class Numeric
  def fraction_of(n)
    self.to_f / n.to_f
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

      @all_ingredients << Quantity.new(ingredient: ingredient_model, amount: amount)
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
    summary_table = Terminal::Table.new(title: "Ingredients for #{name}", headings: ['Ingredient', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      @all_ingredients.each do |ingredient|
        t.add_row [ingredient.to_s, ingredient.calories.round, "#{ingredient.carbohydrate.round}g", "#{ingredient.fat.round}g", "#{ingredient.protein.round}g", "#{ingredient.sugar.round}g", "#{ingredient.fibre.round}g"]
      end
      t.add_separator
      t.add_row ['TOTALS', calories.round, "#{carbohydrate.round}g", "#{fat.round}g", "#{protein.round}g", "#{sugar.round}g", "#{fibre.round}g"]
      t.add_separator
      t.add_row ["MACRO %s", '-', "#{carbohydrate_percentage.round}%", "#{fat_percentage.round}%", "#{protein_percentage.round}%", "#{sugar_percentage.round}%", "#{fibre_percentage.round}%"]
    end

    summary_table
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
    summary_table = Terminal::Table.new(title: "Meals for #{Time.now.strftime("%A, %b %d %Y")}", headings: ['Name', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      @all_meals.each do |meal|
        t.add_row [meal.name, meal.calories.round, "#{meal.carbohydrate.round}g", "#{meal.fat.round}g", "#{meal.protein.round}g", "#{meal.sugar.round}g", "#{meal.fibre.round}g"]
      end
      t.add_separator
      t.add_row ['TOTALS', calories.round, "#{carbohydrate.round}g", "#{fat.round}g", "#{protein.round}g", "#{sugar.round}g", "#{fibre.round}g"]
      t.add_separator
      t.add_row ["MACRO %s", '-', "#{carbohydrate_percentage.round}%", "#{fat_percentage.round}%", "#{protein_percentage.round}%", "#{sugar_percentage.round}%", "#{fibre_percentage.round}%"]
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
