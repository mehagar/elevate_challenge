class SessionsController < ApplicationController
  def sign_in
    # receive credentials
    #
    render json: { 'token': 'some_token' }.to_json
  end
end
