require 'rack/protection'
#require 'sinatra/base'

use Rack::Session::Cookie, :secret => ENV['secret']
use Rack::Protection
use Rack::Protection::EscapedParams
use Rack::Protection::FormToken


root = ::File.dirname(__FILE__)
require ::File.join( root, 'app' )
run Tasklist.new
