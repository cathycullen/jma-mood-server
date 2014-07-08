get '/mood-states' do
  puts "/mood-states called"

  if session[:user_id]
    MoodState.where(:user_id => [nil, session[:user_id]]).to_json
  else
    MoodState.where(:user_id => nil).to_json
  end
end
