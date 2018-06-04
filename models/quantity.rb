class Quantity < Sequel::Model
  many_to_one :ingredient

  def to_s
    "#{quantity} #{ingredient.unit} of #{ingredient.name}"
  end

  def multiplier
    @multiplier = 1

    if quantity != ingredient.amount
      @multiplier = quantity.to_f.fraction_of ingredient.amount
    end

    @multiplier
  end

  def calories
    ingredient.calories * multiplier
  end

  def carbohydrate
    ingredient.carbohydrate * multiplier
  end

  def sugar
    ingredient.sugar * multiplier
  end

  def fat
    ingredient.fat * multiplier
  end

  def fibre
    ingredient.fibre * multiplier
  end

  def protein
    ingredient.protein * multiplier
  end

  def summary
    rows = []
    rows << ['Calories', "#{calories} kcal"]
    rows << ['Carbs', "#{carbohydrate}g"]
    rows << ['Sugar', "#{sugar}g"]
    rows << ['Fat', "#{fat}g"]
    rows << ['Protein', "#{protein}g"]
    rows << ['Fibre', "#{fibre}g"]
    Terminal::Table.new rows: rows, title: "#{@amount} #{@ingredient.unit} of #{@ingredient.name}"
  end
end
