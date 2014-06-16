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
  puts "/results session[:foo] #{  session[:foo] }"
  #erb :results
  session[:foo]
end

get '/mood-states' do
	puts "/mood-states"
	["Adventurous", "Aggravated"].to_json
end
