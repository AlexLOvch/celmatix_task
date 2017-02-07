# frozen_string_literal: true
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  protected

  def authenticate_request!
    return invalid_authentication unless payload

    load_current_user!
    invalid_authentication unless @current_user
  end

  def invalid_authentication
    json_response({ error: 'Invalid Request' }, status: :unauthorized)
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  def load_current_user!
    @current_user = User.find_by(id: payload['user_id'])
  end
end
