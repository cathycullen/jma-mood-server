require 'sinatra'
require 'dotenv'
require 'json'
require './mood'


  @@mood_states = []
  puts "initialize moods"
  File.open("moods.txt", "r") do |f|
    f.each_line do |l|
      @@mood_states <<  l.chomp
    end
  end
  puts "mood count #{@@mood_states.count}"  
 
before '*' do
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT"
  response.headers["Access-Control-Allow-Headers"] = "Content-Type"
end

get '/mood-states' do 
  puts "response: #{response}"
  puts "response.headers: #{response.headers}"
  puts "/moods"
  @@mood_states.to_json
end

get '/submit-mood' do 
  puts "Hello submit mood"
    if params[:mood]
      puts "Mood:  #{params[:mood]}"
    end
    if params[:origin]
      puts "Origin:  #{params[:origin]}"
    end
end

