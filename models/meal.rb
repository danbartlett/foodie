require_relative '../lib/macro_aggregates'
require_relative '../lib/macro_percentages'
require_relative '../lib/summary_table'

class Meal < Sequel::Model
  include MacroAggregates
  include MacroPercentages

  one_to_many :quantities

  def to_s
    name
  end

  def foods
    quantities
  end

  def add_new(ingredient, quantity)
    Quantity.create(meal_id: self.id, ingredient_id: ingredient.id, quantity: quantity)
  end

  def summary
    SummaryTable.new(klass: self, title: "Ingredients for #{name}").table
  end
end
