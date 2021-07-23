Sequel.migration do
  up do
    create_table(:riders) do
      primary_key :id
      String :full_name, null: false
      String :email, null: false
      String :lng, null: false
      String :lat, null: false
    end
  end

  down do
    drop_table(:riders)
  end
end
