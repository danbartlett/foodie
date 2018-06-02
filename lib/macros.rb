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
    protein * 4 / calories * 100
  end

  def carbohydrate_percentage
    carbohydrate * 4 / calories * 100
  end

  def sugar_percentage
    sugar * 4 / calories * 100
  end

  def fat_percentage
    fat * 9 / calories * 100
  end

  def fibre_percentage
    fibre * 9 / calories * 100
  end
end
