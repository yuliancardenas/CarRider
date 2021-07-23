require 'geokit'

class RidesHelper

  attr_reader :ride, :client

  def initialize(ride_id)
    @client = WompiClient.new(ENV['WOMPI_PRIVATE_KEY'], ENV['WOMPI_PUBLIC_KEY'])
    @ride = Ride.where(id: ride_id).first
  end

  def finish_ride(payload)
    # Calculate price
    start = JSON.parse(ride.start)
    finish = JSON.parse(ride.finish)

    distance = distance(start, finish)
    elapsed_minutes = (DateTime.parse(Time.now.to_s).strftime('%Q').to_i - DateTime.parse(ride.created_at).strftime('%Q').to_i) * 0.0000167
    price = ((distance * 1000) + (elapsed_minutes * 200) + 3500).to_i

    ride.update(price: price)

    # Create transaction in WOMPI
    payment_method = PaymentMethod.where(id: payload["payment_method_id"]).first
    response_body = @client.create_payment(
      payment_method.wompi_id,
      price * 100,
      payment_method.rider.email,
      payment_method.token,
      "CARD",
      "Payment for ride #{ride.id}"
    )

    # Save payment in database
    payment = Payment.new
    payment.ride_id = ride.id
    payment.payment_method_id = payment_method.id
    payment.price = price
    payment.created_at = Time.now
    payment.save

    response_body
  end

  private

  def distance(start, finish)
    current_location = Geokit::LatLng.new(start["lat"], start["lng"])
    destination = "#{finish["lat"]},#{finish["lng"]}"
    current_location.distance_to(destination) * 1.60934
  end
end