

require 'erb'

get '/' do
  @tasks = Task.all
  erb :index
end

post '/add' do
  @task = Task.new
  @task.name = params[:name]
  if @task.name != ""
    @task.is_complete = false
    @task.save
  end
  redirect '/'
end


post '/clearComplete' do
  @tasks = Task.all
    @tasks.each do |task|
      if task.is_complete
        task.destroy
      end
    end
  redirect '/'
end

post '/:id/toggleComplete' do
  @task = Task.get(params[:id])
  @task.is_complete = !(@task.is_complete)
  @task.save
  redirect '/'
end

