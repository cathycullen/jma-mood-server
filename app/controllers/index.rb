get '/' do
  redirect "/profile"
end

<<<<<<< HEAD
get '/setter' do
	puts "/setter:  session.inspect: #{session.inspect}"
	erb :index
end

get '/ajax-setter' do
	session[:foo] = "bar"
	puts "/ajax-setter #{session[:foo]}"
	puts "/ajax-setter session.inspect: #{session.inspect}"
	session[:foo]
end

get '/results' do
	puts "/results session.inspect: #{session.inspect}"
	puts "/results session[:foo] : #{session[:foo]}"
	#puts{session[params[:client_cookie].to _sym]}"
	session[:foo]
=======
get "/setter" do
  erb :index
end

get "/ajax-setter" do
  puts "response.headers: #{response.headers}"
  session[:foo] = "bar"
  puts "/ajax-setter session[:foo] #{  session[:foo] }"
  session[:foo]
end

get "/results" do
  puts "/results session[:foo] #{  session[:foo] }"
  #erb :results
  session[:foo]
>>>>>>> 6c863debea24c565670fbb46d9ae4a0549ae4a07
end

get '/mood-states' do
	puts "/mood-states called"
	["Adventurous", "Aggravated"].to_json
end


get '/inspect-session' do
	puts "/inspect-session"
  session.inspect
end

get '/populate-session' do
	puts "/populate-session"
  session.inspect
end
