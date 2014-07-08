get '/' do
  redirect "/profile"
end

get '/results' do
  puts "/results session.inspect: #{session.inspect}"
  puts "/results session[:foo] : #{session[:foo]}"
  #puts{session[params[:client_cookie].to _sym]}"
  session[:foo]
end

get '/inspect-session' do
  puts "/inspect-session"
  session.inspect
end

