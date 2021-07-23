require 'sequel'
require 'dotenv'

Sequel.connect(
  adapter: 'postgres',
  host: ENV['HOST'],
  port: ENV['PORT'],
  database: ENV['DATABASE'],
  user: ENV['USER'],
  password: ENV['PASSWORD']
)
