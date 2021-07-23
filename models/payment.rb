require 'sequel'

class Payment < Sequel::Model(:payments)
  one_to_one :ride
  one_to_one :payment_method
end
