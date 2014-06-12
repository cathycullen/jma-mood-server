get "/profile" do
  redirect "/login" unless session[:user_id]
  @user = User.find(session[:user_id])

  erb :profile
end

get "/currentUser" do

	retval = "{}"
	puts "/currentUser session session[:user_id]: #{session[:user_id]}"
	puts "/currentUser cookies cookies[:user_id]: #{cookies[:user_id]}"

  @some_cookie = request.cookies["user_id"]
	if session[:user_id]

	  @user = User.find(session[:user_id])
	  puts "@user: #{@user}"
		if @user 
			puts "@user: @user: #{@user} @user.to_json: #{@user.to_json}"
			retval = @user.to_json
		else "{}"
		end
	else "{}"
	end
	puts "/currentUser returning: #{retval}"
	retval
end
