require "sinatra"
require 'pry'

require_relative '../database'
require_relative '../services/wompi'

require_relative '../models/payment_method'
require_relative '../models/rider'
require_relative '../models/driver'
require_relative '../models/ride'

class RidersController

  attr_reader :rider, :client

  def initialize(rider_id)
    @client = WompiClient.new('private_key_goes_here')
    @rider = Rider.where(id: rider_id).first
  end

  def create_payment_method(payload)
    response_body = @client.create_payment_method(payload["number"], payload["cvc"], payload["exp_month"], payload["exp_year"], payload["card_holder"])

    payment_method = PaymentMethod.new
    payment_method.token = response_body["token"]
    payment_method.created_at = response_body["created_at"]
    payment_method.brand = response_body["brand"]
    payment_method.name = response_body["name"]
    payment_method.last_four = response_body["last_four"]
    payment_method.bin = response_body["bin"]
    payment_method.exp_year = response_body["exp_year"]
    payment_method.exp_month = response_body["exp_month"]
    payment_method.card_holder = response_body["card_holder"]
    payment_method.expires_at = response_body["expires_at"]
    payment_method.rider_id = rider.id

    payment_method.save
    response_body
  end

  def request_ride(payload)
    nearest_driver = Driver.order(Sequel.lit("SQRT(POW(69.1 * (lat::float - #{rider.lat}), 2) + POW(69.1 * (#{rider.lng} - lng::float) * COS(lat::float / 57.3), 2))")).first

    ride = Ride.new
    ride.rider_id = rider.id
    ride.driver_id = nearest_driver.id
    ride.start = { lat: rider.lat, lng: rider.lng }.to_json
    ride.finish = { lat: payload["lat"], lng: payload["lng"] }.to_json
    ride.created_at = Time.now
    ride.save

    ride.values.to_json
  end

end
