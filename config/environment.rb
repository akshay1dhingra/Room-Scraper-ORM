require 'bundler'
Bundler.require

require 'open-uri'


DB = {
  :connection => SQLite3::Database.new("db/room-developement.sqlite")
}

#binding.pry

require_all 'lib'
