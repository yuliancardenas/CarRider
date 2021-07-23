require 'sequel'

class RidesController < Sinatra::Base

  before do
    content_type :json
  end

  ### VERSION 1.0

  put '/:ride_id/finish-ride' do
    json = JSON.parse(request.body.read)
    RidesHelper.new(params['ride_id']).finish_ride(json)
  end

end