class Ingredient < Sequel::Model
  def validate
    super
    errors.add(:carbohydrate, "can't be empty") if carbohydrate.nil?
    errors.add(:sugar, "can't be empty") if sugar.nil?
    errors.add(:fibre, "can't be empty") if fibre.nil?
  end

  def summary
    rows = []
    rows << ['Carbs', "#{carbohydrate_percentage.round}%"]
    rows << ['Sugar', "#{sugar_percentage.round}%"]
    rows << ['Fat', "#{fat_percentage.round}%"]
    rows << ['Protein', "#{protein_percentage.round}%"]
    rows << ['Fibre', "#{fibre_percentage.round}%"]
    Terminal::Table.new rows: rows, title: self.name
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
