require 'faraday'

class WompiClient
  URL_BASE = 'https://sandbox.wompi.co/v1'

  PAYMENT_TOKEN_CREATION = '/tokens/cards'
  PAYMENT_SOURCE_CREATION = '/payment_sources'
  TRANSACTION_CREATION = '/transactions'

  attr_reader :private_key, :public_key, :acceptance_token

  def initialize(private_key, public_key)
    @private_key = private_key
    @public_key = public_key
    @acceptance_token = get_acceptance_token
  end

  def get_acceptance_token
    response = Faraday.get(URL_BASE + "/merchants/#{public_key}")
    JSON.parse(response.body)["data"]["presigned_acceptance"]["acceptance_token"]
  end

  def create_payment_token(number, cvc, exp_month, exp_year, card_holder)
    response = Faraday.post(URL_BASE + PAYMENT_TOKEN_CREATION) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{public_key}"
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

  def create_payment_source(token, email)
    response = Faraday.post(URL_BASE + PAYMENT_SOURCE_CREATION) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{private_key}"
      req.body = {
        type: "CARD",
        token: token,
        customer_email: email,
        acceptance_token: acceptance_token
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
