#require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'

class Tasklist < Sinatra::Application

  configure :production do
    set :clean_trace, true
  end

end

require_relative 'models/task.rb'
require_relative 'routes/main.rb'
