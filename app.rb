require 'data_mapper'

require_relative 'routes/main.rb'
require_relative 'models/task.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'])
Task.auto_upgrade!
DataMapper.finalize
