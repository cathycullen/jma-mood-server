post "/logout" do
  if token = AuthToken.find_by(token: params[:token])
    token.destroy
  end

  200
end

get '/submit-login' do
  content_type :json

  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    token = user.auth_tokens.create

    user_attributes = user.attributes

    user_attributes[:token] = token.token
    user_attributes.to_json
  else
    puts "\nAUTHENTICATION: FAILED."

    # return 401, authentication failed status
    401
  end
end

