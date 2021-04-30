class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  protected

  def authenticate
    user = authenticate_or_request_with_http_token do |token, _options|
      User.find_by(auth_token: token)
    end

    head :unauthorized if user.nil?

    user
  end

  def current_user
    @current_user ||= authenticate
  end
end
