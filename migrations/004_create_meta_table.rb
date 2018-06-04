Sequel.migration do
  change do
    create_table(:metas) do
      primary_key :id
      DateTime :date
      Integer :garmin_active_calories
      Integer :garmin_total_calories
      Integer :steps

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
