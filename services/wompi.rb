require 'faraday'

class WompiClient
  URL_BASE = 'https://sandbox.wompi.co/v1'
  PAYMENT_METHOD_CREATION = '/tokens/cards'
  TRANSACTION_CREATION = '/transactions'

  attr_reader :private_key

  def initialize(private_key)
    @private_key = private_key
  end

  def create_payment_method(number, cvc, exp_month, exp_year, card_holder)
    response = Faraday.post(URL_BASE + PAYMENT_METHOD_CREATION) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{private_key}"
      req.body = {
        number: number,
        cvc: cvc,
        exp_month: exp_month,
        exp_year: exp_year,
        card_holder: card_holder
      }.to_json
    end

    response.body
  end

  def create_payment(source_id, amount, customer_email, token, type, internal_ref)
    response = Faraday.post(URL_BASE + TRANSACTION_CREATION) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{private_key}"
      req.body = {
        payment_source_id: source_id,
        amount_in_cents: amount,
        currency: "COP",
        customer_email: customer_email,
        reference: internal_ref,
        payment_method: {
          type: type,
          token: token,
          installments: 2
        }
      }.to_json
    end

    response.body
  end
end
