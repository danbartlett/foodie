require_relative '../lib/macro_aggregates'
require_relative '../lib/macro_percentages'

class Day
  include MacroAggregates
  include MacroPercentages

  attr_reader :foods, :date

  def initialize(date:, meals:)
    @foods = meals
    @date = date
  end

  def meta
    Meta.first(date: date)
  end

  def summary
    SummaryTable.new(klass: self, title: "Meals for #{date.strftime("%A, %b %d %Y")}", date: date).table
  end
end
