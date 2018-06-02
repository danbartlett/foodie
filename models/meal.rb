require_relative '../lib/macro_aggregates'
require_relative '../lib/macro_percentages'
require_relative '../lib/summary_table'

class Meal
  include MacroAggregates
  include MacroPercentages

  attr_reader :name, :foods

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

  def to_s
    name
  end

  def summary
    SummaryTable.new(klass: self, title: "Ingredients for #{name}").table
  end
end
