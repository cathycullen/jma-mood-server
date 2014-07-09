get "/login" do
  if session[:user_id]
    redirect "/profile"
  else
    erb :login
  end
end


post "/all-coaches" do
  @coaches = Coach.all
end


get "/all-coaches" do
  @coaches = Coach.all
  @coaches.to_json
end

post "/login" do
  @user = User.find_by(email: params[:email])
  if @user
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/profile"
    else
      @error = "Invalid username or password"
      erb :login
    end
  else
    @error = "User not found #{params[:email]} users:  #{User.first}"
  end
end

post "/logout" do
  session.clear
  redirect "/login"
end

get "/set-session" do
  session[:user_id] = params[:user_id]
  puts "session[:user_id]: #{session[:user_id]}"
  session[:user_id]
end

get "/get-session" do
  puts "get-session session[:user_id] #{session[:user_id]}"
  session[:user_id]
end

get '/submit-login' do
  puts "/submit-login session.inspect: #{session.inspect}"
  puts "/submit-login params #{params}"
  retval = ""
  if params[:email]
    @user = User.find_by(email: params[:email])
    puts "/submit-login @user: #{@user}"
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      puts "\nAUTHENTICATION: SUCCESS"
      puts "session[:user_id] set to: #{session[:user_id]}"
      retval = @user.to_json
    else
      puts "\nAUTHENTICATION: FAILED."
    end
  end
  retval
end

