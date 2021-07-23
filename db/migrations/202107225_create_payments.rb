Sequel.migration do
  up do
    create_table(:payments) do
      primary_key :id
      foreign_key :ride_id, :rides
      foreign_key :payment_method_id, :payment_methods
      Float :price, null: false
      String :created_at, null: false
    end
  end

  down do
    drop_table(:payments)
  end
end
