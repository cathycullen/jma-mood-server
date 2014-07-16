get '/submit-mood' do
  if user = User.find_by(id: session[:user_id])
    if params[:mood] && params[:origin] && params[:energy_level]
      mood = Mood.new(mood: params[:mood],
                      internal_external: params[:origin],
                      thoughts: params[:thoughts],
                      energy_level: params[:energy_level],
                      user: user)
      mood.save

      #if this mood does not exist in mood states then add to mood states for this user.
      if MoodState.where(:state => params[:mood], :user_id => [nil, session[:user_id]]).count == 0
        MoodState.create(:state => params[:mood], :user_id => session[:user_id])
        puts "Custom mood #{params[:mood]} submitted for user #{session[:user_id]}"
      end

      content_type :json
      mood.to_json
    else
      # return a 400 status, since required parameters are missing
      400
    end
  else
    # return a 403 status, since the user isn't authenticated
    403
  end
end

get '/mood-report-last-week' do
  if session[:user_id]
    Mood.where(:user_id => session[:user_id], :created_at => 1.week.ago..Time.now).to_json
  else
    ""
  end
end

get '/mood-report-last-month' do
  if session[:user_id]
    Mood.where(:user_id => session[:user_id], :created_at => 1.month.ago..Time.now).to_json
  else
    ""
  end
end

get '/send-weekly-mood-report' do
  puts "/send-weekly-mood-report"
  if session[:user_id]
      @user = User.find(session[:user_id])
      moods = Mood.where(:user_id => session[:user_id], :created_at => 1.week.ago..Time.now)

      puts "send weekly mood report call mailer"
      email = Mailer.send_weekly_mood_report(@user, @user.coach, moods)
      email.deliver
      retval = moods.to_json
  else
    puts "no session user id"
    ""
  end
end


get '/send-monthly-mood-report' do
  puts "/send-monthly-mood-report"
  if session[:user_id]
      @user = User.find(session[:user_id])
      moods = Mood.where(:user_id => session[:user_id], :created_at => 1.month.ago..Time.now)

      email = Mailer.send_weekly_mood_report(@user, @user.coach, moods)
      email.deliver
      retval = moods.to_json
  else
    ""
  end
end


get "/all-moods" do
  moods = Mood.all

  content_type :json
  moods.to_json
end


