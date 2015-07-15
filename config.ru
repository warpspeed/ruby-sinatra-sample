require 'rack/protection'
require 'sinatra'

use Rack::Session::Cookie, :secret => ENV['SECRET_KEY']
use Rack::Protection
use Rack::Protection::EscapedParams
use Rack::Protection::FormToken


require './app'
run Sinatra::Application
