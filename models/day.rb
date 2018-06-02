require_relative '../lib/macros'

class Day
  include Macros

  def initialize(*meals)
    @foods = meals
  end

  def summary
    summary_table = Terminal::Table.new(title: "Meals for #{Time.now.strftime("%A, %b %d %Y")}", headings: ['Name', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      @foods.each do |meal|
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
