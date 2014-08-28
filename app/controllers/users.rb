get "/logged-in" do
  if params[:token] && AuthToken.exists?(token: params[:token])
    200
  else
    401
  end
end

get '/forgot-password' do
  if @user = User.find_by(email: params[:email])
    puts "Found user: #{@user.inspect}"

    email = Mailer.send_password_link(@user)
    email.deliver

    # send a short status message as the response
    "reset email sent"
  else
    # return 404 status since we couldn't find a user for the
    # submitted email address
    404
  end
end

get '/password-form' do
  # called from user email link
  if params[:token]
    @token = params[:token]
     erb :password_reset_form
  else
    #redirect "/login" bad token
    puts "/password_form Error:  bad token received"
  end
end

post '/password-reset' do
  if params[:token] && params[:password]  && params[:password_check]
    if params[:password] == params[:password_check]
      @user = User.find_by(reset_token:  params[:token])
      if(@user)
        @user.password = params[:password]
        @user.save
        "Password has been updated."
      else
        "Password Reset User not found"
      end
    else
      "Password Reset Passwords do not match"
    end
  else
    "Password Reset is Missing Parameters"
  end
end

get '/create-new-user' do
  # currently this doesn't work, because the form in
  # the phone gap app doesn't include an input to select
  # a coach
  puts "/create-new-user: params:  #{params}"

  #make sure the user does not already have a login
  @user = User.where(:email => params[:email])

  if @user.nil?
    @coach = Coach.find_by(name: params[:coach])
    if params[:email] && params[:password] && @coach
      puts "coach #{@coach} : #{@coach.name}"
      @user = User.create(name: params[:name],
                          email: params[:email],
                          role: "client",
                          password: params[:password],
                          coach_id: @coach.id)

      email = Mailer.send_welcome_email(@user)
      email.deliver
      email  = Mailer.alert_admin_new_user(@user)
      email.deliver

      content_type :json

      token = @user.auth_tokens.create
      user_attributes = @user.attributes
      user_attributes[:token] = token.token
      user_attributes.to_json
    else
      "Missing parameters.  User #{params[:name]} not added"
      # return a 400 status, since the request didn't include the required
      # parameters
      400
  end
  else
      "User already registered.  User #{params[:email]} not added"
      # return a 400 status, since the request was invalid
      # parameters
      400
  end
end

get "/all-users" do
  users = User.all

  content_type :json
  users.to_json
end

