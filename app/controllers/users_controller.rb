# frozen_string_literal: true
class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      json_response({ status: 'User created successfully' }, status: :created)
    else
      json_response({ errors: user.errors.full_messages }, status: :bad_request)
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)

    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: { auth_token: auth_token }, status: :ok
    else
      json_response({ error: 'Invalid email / password' }, status: :unauthorized)
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
