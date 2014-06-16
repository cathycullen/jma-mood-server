get '/' do
  redirect "/profile"
end

get "/setter" do
  erb :index
end

get "/ajax-setter" do
  session[:foo] = "bar"
end

get "/results" do
  erb :results
end

get '/mood-states' do
	puts "/mood-states"
	["Adventurous", "Aggravated"].to_json
end
