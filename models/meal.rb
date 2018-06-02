class Meal
  attr_reader :name

  def initialize(name:, ingredients:)
    @all_ingredients = []
    @name = name

    ingredients.each do |ingredient|
      name, amount = ingredient.split(',')
      ingredient_model = Ingredient.first(Sequel.like(:name, "#{name}%"))
      raise IngredientNotFound, "#{name} not found!" unless ingredient_model

      @all_ingredients << Quantity.new(ingredient: ingredient_model, amount: amount)
    end
  end

  def calories
    @all_ingredients.map(&:calories).sum
  end

  def carbohydrate
    @all_ingredients.map(&:carbohydrate).sum
  end

  def sugar
    @all_ingredients.map(&:sugar).sum
  end

  def fat
    @all_ingredients.map(&:fat).sum
  end

  def fibre
    @all_ingredients.map(&:fibre).sum
  end

  def protein
    @all_ingredients.map(&:protein).sum
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
    summary_table = Terminal::Table.new(title: "Ingredients for #{name}", headings: ['Ingredient', 'Calories', 'Carbs', 'Fat', 'Protein', 'Sugar', 'Fibre']) do |t|
      @all_ingredients.each do |ingredient|
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
