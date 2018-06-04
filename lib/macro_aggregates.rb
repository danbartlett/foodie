module MacroAggregates
  def calories
    foods.map(&:calories).sum
  end

  def carbohydrate
    foods.map(&:carbohydrate).sum
  end

  def sugar
    foods.map(&:sugar).sum
  end

  def fat
    foods.map(&:fat).sum
  end

  def fibre
    foods.map(&:fibre).sum
  end

  def protein
    foods.map(&:protein).sum
  end
end
