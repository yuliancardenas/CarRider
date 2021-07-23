require 'sinatra/base'

Dir.glob('./config/database.rb').each { |file| require file }
Dir.glob('.app/{models, controllers}/*.rb').each { |file| require file }

map('/v1/rides') { run RidesController }
map('/v1/riders') { run RidersController }
