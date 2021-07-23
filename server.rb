require 'sinatra'

# Controllers
require './controllers/rides_controller'
require './controllers/riders_controller'

# Database
require './database'

before do
  content_type :json
end

# Version 1.0

# Endpoints

# To allow users to save payment methods
post '/v1/rider/:rider_id/create-payment-method' do
  RidersController.new(params['rider_id']).create_payment_method(JSON.parse(request.body.read))
end

# To allow users to request a ride
post '/v1/rider/:rider_id/request-ride' do
  RidersController.new(params['rider_id']).request_ride(JSON.parse(request.body.read))
end

# To allow drivers to finish the ride
put '/v1/ride/:ride_id/finish-ride' do
  RidesController.new(params['ride_id']).finish_ride(JSON.parse(request.body.read))
end
