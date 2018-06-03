require 'sequel'
require 'csv'
require 'pry'
require 'terminal-table'

DB = Sequel.connect 'postgres://postgres:@localhost:5432/foodie_development'

# Enable automatic timestamp updates on all models,
# if created_at & updated_at columns exist
Sequel::Model.plugin :timestamps

require_relative './models/ingredient.rb'
require_relative './models/quantity.rb'
require_relative './models/meal.rb'
require_relative './models/day.rb'

class IngredientNotFound < StandardError; end

class Numeric
  def fraction_of(n)
    self.to_f / n.to_f
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

require_relative './log.rb'
