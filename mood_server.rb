require 'sinatra'
require 'dotenv'
require 'json'

before '*' do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
end

get '/hello_server' do 
  puts "Hello server"
  "hello server"
end

get '/testing-get' do 
  puts "hello testing-get"
  "testing-get"
end

post '/testing-post' do 
  puts "hello testing-post"
  "testing-post"
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
