helpers do
  def user_for_auth_token
    if token = AuthToken.find_by(token: params[:token])
      token.user
    end
  end
end
