require 'sequel'
require 'dotenv'

Sequel.migration do
  up do
    riders = DB[:riders]

    # Populate the riders
    riders.insert(id: 1, full_name: 'Yulián', email: 'yulian@nexos.com', lng: '-74.07348141698203', lat: '4.730312619298383')
    riders.insert(id: 2, full_name: 'Juan', email: 'juan@nexos.com', lng: '-75.07348141698203', lat: '4.780312619298383')
    riders.insert(id: 3, full_name: 'Ramiro', email: 'ramiro@nexos.com', lng: '-72.07348141698203', lat: '4.740312619298383')
    riders.insert(id: 4, full_name: 'Sebastian', email: 'sebastian@nexos.com', lng: '-71.07348141698203', lat: '4.790312619298383')
    riders.insert(id: 5, full_name: 'Oscar', email: 'oscar@nexos.com', lng: '-76.07348141698203', lat: '4.90312619298383')
  end
end
