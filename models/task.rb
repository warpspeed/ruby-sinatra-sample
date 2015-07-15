require 'data_mapper'

class Task
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :is_complete, Boolean
end
