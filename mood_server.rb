require 'sinatra'
require 'dotenv'
require 'json'

before do
  if request.request_method == 'OPTIONS'
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"

    halt 200
  end
end
options '/*' do
  response["Access-Control-Allow-Headers"] = "origin, x-requested-with, content-type"
end
  
  
  
get '/hello_server' do 
  puts "Hello server"
end

post '/submit_mood' do 
  puts "Hello submit mood"
    if params[:mood]
      puts "params:  #params[:mood]]"
    end
end


post '/submit_task' do 
  puts "Hello submit task"
    if params[:task]
      puts "params:  #params[:task]]"
    end
end
