get '/' do
  redirect "/profile"
end

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