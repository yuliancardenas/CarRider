require 'sequel'

class PaymentMethod < Sequel::Model(:payment_methods)
  many_to_one :rider
end
