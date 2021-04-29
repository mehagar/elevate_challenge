class SessionsController < ApplicationController
  def sign_in
    # find user given credentials
    user = User.find_by(email: user_params[:email])

    render json: { 'token': user.auth_token }.to_json
  end

  def user_params
    params.permit(:email, :password)
  end
end
