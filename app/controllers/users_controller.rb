class UsersController < ApplicationController
  def sign_up
    User.create!(user_params)

    head :created
  end

  def user_params
    params.permit(:email, :username, :fullname, :password)
  end
end
