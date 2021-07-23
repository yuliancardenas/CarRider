require 'sequel'
require 'dotenv'

Sequel.migration do
  up do
    drivers = DB[:drivers]

    # Populate the drivers
    drivers.insert(id: 1, full_name: 'Rodrigo', email: 'rodrigo@nexos.com', lng: '-75.07348141698203', lat: '4.730312619298383')
    drivers.insert(id: 2, full_name: 'Jefferson', email: 'jefferson@nexos.com', lng: '-72.07348141698203', lat: '4.780312619298383')
    drivers.insert(id: 3, full_name: 'Junior', email: 'junior@nexos.com', lng: '-73.07348141698203', lat: '4.640312619298383')
    drivers.insert(id: 4, full_name: 'Fernando', email: 'fernando@nexos.com', lng: '-71.07348141698203', lat: '4.590312619298383')
    drivers.insert(id: 5, full_name: 'Jaime', email: 'jaime@nexos.com', lng: '-72.07348141698203', lat: '4.81312619298383')
  end
end
