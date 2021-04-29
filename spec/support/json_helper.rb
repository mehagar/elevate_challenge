module JsonHelper
  def json
    reparse_and_never_memoize_as_response_may_change = lambda do
      JSON.parse(response.body, symbolize_names: true)
    end
    reparse_and_never_memoize_as_response_may_change.call
  end

  def json_request_headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end
end
