class SessionsController < ApplicationController
  def sign_in
    user = User.find_by(email: user_params[:email])

    if (authenticated_user = user.authenticate(user_params[:password]))
      render json: { 'token': authenticated_user.auth_token }.to_json
    else
      head :unauthorized
    end
  end

  def user_params
    params.permit(:email, :password)
  end
end
