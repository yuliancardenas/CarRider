require 'sequel'

class PaymentMethod < Sequel::Model(:payment_methods)
  one_to_one :rider
end
