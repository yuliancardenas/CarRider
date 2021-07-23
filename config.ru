require 'sinatra/base'
require './carriders'

Dir.glob('./{config,controllers,services,models,helpers}/*.rb').sort.each { |file| require file }

map('/v1/riders') { run RidersController }
map('/v1/rides') { run RidesController }
