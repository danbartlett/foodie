Sequel.migration do
  change do
    create_table(:ingredients) do
      primary_key :id
      String :name, null: false
      String :brand
      String :product_link
      Integer :amount, null: false
      String :unit, null: false
      Integer :calories, null: false
      Float :carbohydrate, null: false
      Float :sugar, null: false
      Float :fat, null: false
      Float :protein, null: false
      Float :fibre, null: false
    end
  end
end
