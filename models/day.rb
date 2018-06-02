require_relative '../lib/macro_aggregates'
require_relative '../lib/macro_percentages'

class Day
  include MacroAggregates
  include MacroPercentages

  attr_reader :foods

  def initialize(*meals)
    @foods = meals
  end

  def summary
    SummaryTable.new(klass: self, title: "Meals for #{Time.now.strftime("%A, %b %d %Y")}").table
  end
end
