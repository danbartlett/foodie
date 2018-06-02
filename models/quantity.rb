class Quantity
  attr_reader :amount, :ingredient

  def initialize(ingredient:, amount:)
    @ingredient = ingredient
    @amount = amount

    if amount && amount != ingredient.amount
      @multiplier = amount.to_i.fraction_of ingredient.amount
    end
  end

  def calories
    @ingredient.calories * @multiplier
  end

  def carbohydrate
    @ingredient.carbohydrate * @multiplier
  end

  def sugar
    @ingredient.sugar * @multiplier
  end

  def fat
    @ingredient.fat * @multiplier
  end

  def fibre
    @ingredient.fibre * @multiplier
  end

  def protein
    @ingredient.protein * @multiplier
  end

  def to_s
    "#{amount} #{ingredient.unit} of #{ingredient.name}"
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
