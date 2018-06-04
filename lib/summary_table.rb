require 'colorize'

class SummaryTable
  attr_reader :klass, :title, :meta

  def initialize(klass:, title:, date:)
    @klass = klass
    @title = title
    @meta = Meta.first(date: date)
  end

  def balance
    symbol = (meta.garmin_total_calories <=> klass.calories) == -1 ? "+" : "-"
    prefixed_balance = "#{symbol}#{(meta.garmin_total_calories - klass.calories).round}"
    return prefixed_balance.green if symbol == "-"
    return prefixed_balance.gsub('-','').red if symbol == "+" # <=> Adds a '-' so remove it
  end

  def table
    calorie_balance = balance
    Terminal::Table.new(title: title, headings: ['Name', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      klass.foods.each do |food|
        t.add_row [food.to_s, food.calories.round, "#{food.carbohydrate.round}g", "#{food.fat.round}g", "#{food.protein.round}g", "#{food.sugar.round}g", "#{food.fibre.round}g"]
      end
      t.add_separator
      t.add_row ['TOTALS', klass.calories.round, "#{klass.carbohydrate.round}g", "#{klass.fat.round}g", "#{klass.protein.round}g", "#{klass.sugar.round}g", "#{klass.fibre.round}g"]
      t.add_separator
      t.add_row ["MACRO %s", '-', "#{klass.carbohydrate_percentage.round}%", "#{klass.fat_percentage.round}%", "#{klass.protein_percentage.round}%", "#{klass.sugar_percentage.round}%", "#{klass.fibre_percentage.round}%"]
      t.add_separator
      t.add_row ['ACTIVITY', "Total: #{meta.garmin_total_calories}", "Active: #{meta.garmin_active_calories}", "Steps: #{meta.steps}" ]
      t.add_separator
      t.add_row ['BALANCE', calorie_balance]
    end
  end
end
