require 'sequel'

class RidersController < Sinatra::Base

  before do
    content_type :json
  end

  ### VERSION 1.0

  post '/:rider_id/request-ride' do
    json = JSON.parse(request.body.read)
    RidersHelper.new(params['rider_id']).request_ride(json)
  end

  post '/:rider_id/create-payment-method' do
    json = JSON.parse(request.body.read)
    RidersHelper.new(params['rider_id']).create_payment_method(json)
  end

end