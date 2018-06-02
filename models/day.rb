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
