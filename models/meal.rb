require_relative '../lib/macro_aggregates'
require_relative '../lib/macro_percentages'

class Meal
  include MacroAggregates
  include MacroPercentages

  attr_reader :name

  def initialize(name:, ingredients:)
    @foods = []
    @name = name

    ingredients.each do |ingredient|
      name, amount = ingredient.split(',')
      ingredient_model = Ingredient.first(Sequel.like(:name, "#{name}%"))
      raise IngredientNotFound, "#{name} not found!" unless ingredient_model

      @foods << Quantity.new(ingredient: ingredient_model, amount: amount)
    end
  end

  def summary
    summary_table = Terminal::Table.new(title: "Ingredients for #{name}", headings: ['Ingredient', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      @foods.each do |ingredient|
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
