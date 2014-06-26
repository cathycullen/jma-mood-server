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


