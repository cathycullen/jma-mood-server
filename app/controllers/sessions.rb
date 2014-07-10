post "/logout" do
  session.clear
  redirect "/login"
end

get '/submit-login' do
  content_type :json

  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    puts "\nAUTHENTICATION: SUCCESS"
    puts "session[:user_id] set to: #{session[:user_id]}"
    user.to_json
  else
    puts "\nAUTHENTICATION: FAILED."

    # return 401, authentication failed status
    401
  end
end

