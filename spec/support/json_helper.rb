module JsonHelper
  def json
    reparse_and_never_memoize_as_response_may_change = lambda do
      JSON.parse(response.body, symbolize_names: true)
    end
    reparse_and_never_memoize_as_response_may_change.call
  end

  def json_request_headers(token = nil)
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    if token
      headers['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
    end

    headers
  end
end
