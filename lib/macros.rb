module Macros
  def calories
    @foods.map(&:calories).sum
  end

  def carbohydrate
    @foods.map(&:carbohydrate).sum
  end

  def sugar
    @foods.map(&:sugar).sum
  end

  def fat
    @foods.map(&:fat).sum
  end

  def fibre
    @foods.map(&:fibre).sum
  end

  def protein
    @foods.map(&:protein).sum
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
end
