require 'sequel'

class Ride < Sequel::Model(:rides)
  one_to_one :driver
  one_to_one :rider
end
