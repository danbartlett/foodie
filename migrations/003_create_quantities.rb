Sequel.migration do
  change do
    create_table(:quantities) do
      primary_key :id
      foreign_key :meal_id, :meals, index: true
      foreign_key :ingredient_id, :ingredients, index: true
      Float :quantity

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
