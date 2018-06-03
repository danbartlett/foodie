Sequel.migration do
  change do
    create_table(:meals) do
      primary_key :id
      String :name

      DateTime :created_at, null: false
      DateTime :updated_at
    end
  end
end
