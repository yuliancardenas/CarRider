Sequel.migration do
  up do
    create_table(:payment_methods) do
      primary_key :id
      foreign_key :rider_id, :riders
      String :token, null: false
      DateTime :created_at, null: false
      String :brand, null: false
      String :name, null: false
      String :last_four, null: false
      String :bin, null: false
      String :exp_year, null: false
      String :exp_month, null: false
      String :card_holder, null: false
      DateTime :expires_at, null: false
      Integer :wompi_id, null: false
    end
  end

  down do
    drop_table(:payment_methods)
  end
end
