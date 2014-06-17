get '/' do
  redirect "/profile"
end

get "/setter" do
  erb :index
end

get "/ajax-setter" do
  puts "response.headers: #{response.headers}"
  session[:foo] = "bar"
  puts "/ajax-setter session[:foo] #{  session[:foo] }"
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
