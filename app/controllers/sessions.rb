get "/login" do
  if session[:user_id]
    redirect "/profile"
  else
    erb :login
  end
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
  puts "/submit-login params #{params}"
  retval = ""
    if params[:email]
      @user = User.find_by(email: params[:email])
      puts "@user: #{@user}"
      if @user 
        if @user.authenticate(params[:password])
          session[:user_id] = @user.id
          response.set_cookie("user_id", @user.id)
          cookies[:user_id] = @user.id
          puts "User was authenticated"
          puts "session[:user_id]: #{session[:user_id]}" 
          puts "/submit-login cookies: #{cookies[:user_id]}"
          #redirect "/profile"
          retval = @user.to_json
        else
          retval = @error = "Invalid username or password"
          #erb :login
        end
      else
        retval = @error = "No User Exists"
        #erb :login
      end
    end
    puts "/submitLogin returning: #{retval}  session id #{session[:user_id]}"
    retval
end

