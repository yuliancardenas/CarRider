class RidersHelper

  attr_reader :rider, :client

  def initialize(rider_id)
    @client = WompiClient.new(ENV['WOMPI_PRIVATE_KEY'], ENV['WOMPI_PUBLIC_KEY'])
    @rider = Rider.where(id: rider_id).first
  end

  def create_payment_method(payload)
    response_body_token = @client.create_payment_token(payload["number"], payload["cvc"], payload["exp_month"], payload["exp_year"], payload["card_holder"])
    response_body_token = JSON.parse(response_body_token)

    payment_method = PaymentMethod.new
    payment_method.token = response_body_token["data"]["id"]
    payment_method.created_at = response_body_token["data"]["created_at"]
    payment_method.brand = response_body_token["data"]["brand"]
    payment_method.name = response_body_token["data"]["name"]
    payment_method.last_four = response_body_token["data"]["last_four"]
    payment_method.bin = response_body_token["data"]["bin"]
    payment_method.exp_year = response_body_token["data"]["exp_year"]
    payment_method.exp_month = response_body_token["data"]["exp_month"]
    payment_method.card_holder = response_body_token["data"]["card_holder"]
    payment_method.expires_at = response_body_token["data"]["expires_at"]
    payment_method.rider_id = rider.id

    response_body_source = @client.create_payment_source(response_body_token["data"]["id"], rider.email)
    response_body_source = JSON.parse(response_body_source)

    payment_method.wompi_id = response_body_source["data"]["id"]

    payment_method.save
    response_body_source.to_json
  end

  def request_ride(payload)
    nearest_driver = Driver.order(Sequel.lit("SQRT(POW(69.1 * (lat::float - #{rider.lat}), 2) + POW(69.1 * (#{rider.lng} - lng::float) * COS(lat::float / 57.3), 2))")).first

    ride = Ride.new
    ride.rider_id = rider.id
    ride.driver_id = nearest_driver.id
    ride.start = { lat: rider.lat, lng: rider.lng }.to_json
    ride.finish = { lat: payload["lat"], lng: payload["lng"] }.to_json
    ride.created_at = Time.now
    ride.price = 0
    ride.save

    ride.values.to_json
  end

end
