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
    		retval = "#{params[:mood]} submitted"

    		#if this mood does not exist in mood states then add to mood states for this user.
        if MoodState.where(:state => params[:mood], :user_id => [nil, session[:user_id]]).count == 0
          MoodState.create(:state => params[:mood], :user_id => session[:user_id])
          puts "Custom mood #{params[:mood]} submitted for user #{session[:user_id]}"
        end

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