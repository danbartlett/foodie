module MacroPercentages
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
