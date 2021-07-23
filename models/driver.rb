require 'sequel'

class Driver < Sequel::Model(:drivers)
  one_to_many :rides, :key => :driver_id
end
