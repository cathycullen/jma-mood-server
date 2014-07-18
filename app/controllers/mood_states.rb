get '/mood-states' do
  content_type :json

  if user_for_auth_token
    MoodState.where(:user_id => [nil, user_for_auth_token.id]).to_json
  else
    MoodState.where(:user_id => nil).to_json
  end
end
