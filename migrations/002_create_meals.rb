Sequel.migration do
  change do
    create_table(:meals) do
      primary_key :id
      String :name
    end
  end
end
