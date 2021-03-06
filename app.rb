require 'sinatra'
require 'config_env'
require 'httparty'
require_relative 'models/weather.rb'
require 'uri'
require "redis"

ConfigEnv.init("#{__dir__}/config/env.rb")
REDIS = Redis.new(url: ENV['REDIS_URL'])

set :port, 3000

get '/' do
  @cities = [
    "Minneapolis",
    "London",
    "New Orleans",
    "Chicago",
    "Phoenix",
    "Jerusalem"
  ]

  @city = params[:city] || "Minneapolis"
  weather = Weather.new(@city)
  @temp = weather.temp
  @icons = weather.icons
  erb :index
end