class SummaryTable
  attr_reader :klass, :title

  def initialize(klass:, title:)
    @klass = klass
    @title = title
  end

  def table
    Terminal::Table.new(title: title, headings: ['Name', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      klass.foods.each do |food|
        t.add_row [food.to_s, food.calories.round, "#{food.carbohydrate.round}g", "#{food.fat.round}g", "#{food.protein.round}g", "#{food.sugar.round}g", "#{food.fibre.round}g"]
      end
      t.add_separator
      t.add_row ['TOTALS', klass.calories.round, "#{klass.carbohydrate.round}g", "#{klass.fat.round}g", "#{klass.protein.round}g", "#{klass.sugar.round}g", "#{klass.fibre.round}g"]
      t.add_separator
      t.add_row ["MACRO %s", '-', "#{klass.carbohydrate_percentage.round}%", "#{klass.fat_percentage.round}%", "#{klass.protein_percentage.round}%", "#{klass.sugar_percentage.round}%", "#{klass.fibre_percentage.round}%"]
    end
  end
end
