class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :sign_in

  def sign_in
    user = User.find_by(email: user_params[:email])

    if (authenticated_user = user.authenticate(user_params[:password]))
      render json: { 'token': authenticated_user.auth_token }
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
