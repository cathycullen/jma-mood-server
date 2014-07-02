get "/profile" do
  redirect "/login" unless session[:user_id]
  @user = User.find(session[:user_id])

  erb :profile
end

get "/currentUser" do
	retval = "{}"
	
	puts "/currentUser session.inspect: #{session.inspect}"
	puts "/currentUser session[:user_id]: #{session[:user_id]}"

	if session[:user_id]

	  @user = User.find(session[:user_id])
		if @user 
			puts "/currentUser @user: @user: #{@user} @user.to_json: #{@user.to_json}"
			retval = @user.to_json
		else "{}"
		end
	else "{}"
	end
	puts "/currentUser returning: #{retval}"
	retval
end

get "/logged-in" do
	retval = "false"
	
	puts "/currentUser session[:user_id]: #{session[:user_id]}"

	if session[:user_id]
	  retval = "true"
	end
	puts "/logged-in returning: #{retval}"
	retval
end

get '/submit-lost-password' do
  puts "/submit-lost-password session.inspect: #{session.inspect}"
	if session[:user_id]

	  @user = User.find(session[:user_id])
		if @user 
			puts "@user: @user: #{@user} @user.to_json: #{@user.to_json}"

    		email = Mailer.send_password_link(@user)
    		email.deliver
			retval = @user.to_json
		else "{}"
		end
	else "{}"
	end
	puts "/currentUser returning: #{retval}"
	retval
end

get '/password-form' do
	# called from user email link
	puts "/password-form called #{params}"
	if params[:token]
		@token = params[:token]
		 erb :password_reset_form
	else
		#redirect "/login" bad token
		puts "/password_form Error:  bad token received"
	end
end

post '/password-reset' do
	puts "/password-reset called #{params}"
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


get '/submit-new-user' do
  puts "/submit-neww-user session.inspect: #{session.inspect}"
retval = ""
#make sure user doesn't already exist

	if params[:name] && params[:email]  && params[:password]  && params[:coach]
			@coach = Coach.where(:name => params[:coach]).first
			if(@coach)
				puts "coach #{@coach} : #{@coach.name}"
				@user = User.create(name: params[:name], email: params[:email], role:  "client", password: params[:password], coach_id: @coach.id)

    		email = Mailer.send_welcome_email(@user)
    		email.deliver
				retval = @user.to_json
			else
				retval = "unable to find coach #{params[:coach]} for user"
			end
		else
			"Missing parameters.  User #{params[:name]} not added"
	end
	retval
end


get '/submit-mood' do 
  puts "/submit-mood session.inspect: #{session.inspect}"
  puts "/submit-mood params #{params}"

  puts "response.headers: #{response.headers}"
  retval = ""
	if params[:mood]  && params[:origin]
    if session[:user_id]
    	user = User.find(session[:user_id])
    	if user
    		mood = Mood.new mood: params[:mood], internal_external: params[:origin]
    		mood.user = user
    		mood.save
    		retval = "#{params[:mood]} submitted}"
    	else
    		retval = "user not found "
    	end
    else
    	retval = "session[:user_id] is not defined"
		end
	else
		retval = "missing parameter mood or origin"
	end
	puts "/submit-mood returning: #{retval}"
	retval
end


