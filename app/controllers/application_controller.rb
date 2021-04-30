class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      User.find_by(auth_token: token)
    end
  end

  def current_user
    @current_user ||= authenticate
  end
end
