# frozen_string_literal: true
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def parsed_response
    JSON.parse(response.body)
  end

  def parsed_response_data
    parsed_response['data']
  end

  def parsed_response_meta
    parsed_response['meta']
  end

  def create_token(user_id)
    JsonWebToken.encode(user_id: user_id)
  end
end
