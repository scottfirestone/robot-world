# require 'models/robot_world'

class RobotWorldApp < Sinatra::Base
  # set :root, File.expand_path("..", __dir__)
  # set :method_override, true

  def robot_world
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite("db/robot_world_test.sqlite3")
    else
      database = Sequel.sqlite("db/robot_world_dev.sqlite3")
    end
    @robot_world ||= RobotWorld.new(database)
end

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_world.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot_world.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = robot_world.find(id)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_world.find(id)
    erb :edit
  end

  post "/robots/:id" do |id|
    @robot = robot_world.update(params[:robot], id)
    redirect "/robots"
  end

  put '/robots/:id' do |id|
    robot_world.update(id, params[:robot])
    redirect "/robots"
  end

  delete '/robots/:id' do |id|
    robot_world.delete(id)
    redirect "/robots"
  end

  not_found do
    erb :error
  end

end
