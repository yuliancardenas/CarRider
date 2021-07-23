require 'sequel'

class Rider < Sequel::Model(:riders)
  one_to_many :payment_methods, :key => :rider_id
  one_to_many :payments, :key => :rider_id
  one_to_many :rides, :key => :rider_id
end
