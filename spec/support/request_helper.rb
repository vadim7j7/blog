module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body).deep_symbolize_keys
    end
  end
end
