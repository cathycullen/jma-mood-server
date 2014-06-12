get '/' do
  redirect "/profile"
end

get '/mood-states' do
	puts "/mood-states"
	["Adventurous", "Aggravated"].to_json
end
