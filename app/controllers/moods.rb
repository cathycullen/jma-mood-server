get '/submit-mood' do
  if user = user_for_auth_token
    if params[:mood] && params[:origin] && params[:energy_level]
      mood = Mood.new(mood: params[:mood],
                      internal_external: params[:origin],
                      thoughts: params[:thoughts],
                      energy_level: params[:energy_level],
                      user: user)
      mood.save

      #if this mood does not exist in mood states then add to mood states for this user.
      if MoodState.where(:state => params[:mood], :user_id => [nil, user.id]).count == 0
        MoodState.create(:state => params[:mood], :user_id => user.id)
        puts "Custom mood #{params[:mood]} submitted for user #{user.id}"
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
  content_type :json

  if user_for_auth_token
    Mood.where(:user_id => user_for_auth_token.id, :created_at => 1.week.ago..Time.now).order("created_at DESC").to_json
  else
    401
  end
end

get '/mood-report-last-month' do
  content_type :json

  if user_for_auth_token
    Mood.where(:user_id => user_for_auth_token.id, :created_at => 1.month.ago..Time.now).order("created_at DESC").to_json
  else
    401
  end
end

get '/send-weekly-mood-report' do
  puts "/send-weekly-mood-report"
  if @user = user_for_auth_token
      @results = Mood.where(:user_id => @user.id, :created_at => 1.week.ago..Time.now).order("created_at DESC")
      @chart_results = @results.group(:energy_level).count

      puts "send weekly mood report call mailer"
      email = Mailer.send_weekly_mood_report(@user, @user.coach, @results, @chart_results)
      email.deliver
      retval = @results.to_json
  else
    401
  end
end


get '/test_send-weekly-mood-report' do
  puts "/test-send-weekly-mood-report"
  if @user = User.where(:email => "cathy@softwareoptions.com").first
    puts "@user #{@user.name}   #{@user.id}"
      @results = Mood.where(:user_id => @user.id, :created_at => 1.week.ago..Time.now).order("created_at DESC")
      @chart_results = @results.group(:energy_level).count

      puts "send weekly mood report call mailer"
      email = Mailer.send_weekly_mood_report(@user, @user.coach, @results, @chart_results)
      email.deliver
      retval = @results.to_json
  else
    401
  end
end

get '/send-monthly-mood-report' do
  puts "/send-monthly-mood-report"
  if @user = user_for_auth_token
      @results = Mood.where(:user_id => @user.id, :created_at => 1.month.ago..Time.now).order("created_at DESC")
      @chart_results = @results.group(:energy_level).count

      email = Mailer.send_weekly_mood_report(@user, @user.coach, @results, @chart_results)
      email.deliver
      retval = @results.to_json
  else
    401
  end
end

get '/user_moods/:id'  do
  @the_moods = Mood.where(:user_id => params[:id])
  @chart_results = @the_moods.group(:energy_level).count
  puts "@chart_results #{@chart_results} mood count: #{@the_moods.count}"
  @the_user  = User.find(params[:id])
  path = request.fullpath 

  puts "path: #{path}"  
  erb :show_user_moods
  end

get "/all-moods" do
  moods = Mood.all

  content_type :json
  moods.to_json
end


get '/test-weekly-mood-report' do
  puts "/user-weekly-mood-report"
  if @user = User.where(:email => "cathy@softwareoptions.com").first
      @results = Mood.where(:user_id => @user.id, :created_at => 1.week.ago..Time.now).order("created_at DESC")
      @chart_results = @results.group(:energy_level).count

      puts "test weekly mood report with graph"
      erb :test_weekly_mood_report
  else
    "nothing found"
  end
end




