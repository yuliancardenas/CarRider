require 'sequel'
require 'pg'

DB = Sequel.connect(
  adapter: 'postgres',
  host: 'localhost',
  database: 'car_riders',
  user: 'yulian',
  password: '123456'
)

DB.create_table? :riders do
  primary_key :id
  String :full_name
  String :email
  String :lng
  String :lat
end

DB.create_table? :drivers do
  primary_key :id
  String :full_name
  String :email
  String :lng
  String :lat
end

DB.create_table? :payment_methods do
  primary_key :id
  foreign_key :rider_id, :riders
  String :token
  DateTime :created_at
  String :brand
  String :name
  String :last_four
  String :bin
  String :exp_year
  String :exp_month
  String :card_holder
  DateTime :expires_at
end

DB.create_table? :rides do
  primary_key :id
  foreign_key :rider_id, :riders
  foreign_key :driver_id, :drivers
  String :start, text: true
  String :finish, text: true
  Float :price
  String :created_at
end

DB.create_table? :payments do
  primary_key :id
  foreign_key :ride_id, :rides
  foreign_key :payment_method_id, :payment_methods
  Float :price
  String :created_at
end

riders = DB[:riders]

# Populate the riders
riders.insert(id: 1, full_name: 'Yulián', email: 'yulian@nexos.com', lng: '-74.07348141698203', lat: '4.730312619298383') if riders.where(id: 1).count.zero?
riders.insert(id: 2, full_name: 'Juan', email: 'juan@nexos.com', lng: '-75.07348141698203', lat: '4.780312619298383') if riders.where(id: 2).count.zero?
riders.insert(id: 3, full_name: 'Ramiro', email: 'ramiro@nexos.com', lng: '-72.07348141698203', lat: '4.740312619298383') if riders.where(id: 3).count.zero?
riders.insert(id: 4, full_name: 'Sebastian', email: 'sebastian@nexos.com', lng: '-71.07348141698203', lat: '4.790312619298383') if riders.where(id: 4).count.zero?
riders.insert(id: 5, full_name: 'Oscar', email: 'oscar@nexos.com', lng: '-76.07348141698203', lat: '4.90312619298383') if riders.where(id: 5).count.zero?

drivers = DB[:drivers]

# Populate the riders
drivers.insert(id: 1, full_name: 'Rodrigo', email: 'rodrigo@nexos.com', lng: '-75.07348141698203', lat: '4.730312619298383') if drivers.where(id: 1).count.zero?
drivers.insert(id: 2, full_name: 'Jefferson', email: 'jefferson@nexos.com', lng: '-72.07348141698203', lat: '4.780312619298383') if drivers.where(id: 2).count.zero?
drivers.insert(id: 3, full_name: 'Junior', email: 'junior@nexos.com', lng: '-73.07348141698203', lat: '4.640312619298383') if drivers.where(id: 3).count.zero?
drivers.insert(id: 4, full_name: 'Fernando', email: 'fernando@nexos.com', lng: '-71.07348141698203', lat: '4.590312619298383') if drivers.where(id: 4).count.zero?
drivers.insert(id: 5, full_name: 'Jaime', email: 'jaime@nexos.com', lng: '-72.07348141698203', lat: '4.81312619298383') if riders.where(id: 5).count.zero?
