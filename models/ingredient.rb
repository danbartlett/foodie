require_relative '../lib/macro_percentages'

class Ingredient < Sequel::Model
  include MacroPercentages

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
end
