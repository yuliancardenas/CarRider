Sequel.migration do
  up do
    create_table(:rides) do
      primary_key :id
      foreign_key :rider_id, :riders
      foreign_key :driver_id, :drivers
      String :start, text: true, null: false
      String :finish, text: true, null: false
      Float :price, null: false
      String :created_at, null: false
    end
  end

  down do
    drop_table(:rides)
  end
end
