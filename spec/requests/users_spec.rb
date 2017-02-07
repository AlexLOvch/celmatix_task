# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:login_data) { { email: 'ex@example.com', password: '12345678' } }
  let(:data) { { name: 'name', email: 'ex@example.com', password: '12345678', password_confirmation: '12345678' } }

  describe 'POST /users' do
    it 'create user' do
      expect do
        post '/users', params: data
      end.to change { User.count }.from(0).to(1)
    end

    it 'returns status code 201' do
      post '/users', params: data
      expect(response).to have_http_status(201)
    end

    it 'returns status code 401 if invalid record' do
      post '/users', params: data.except(:email)
      expect(response).to have_http_status(400)
    end
  end

  describe 'POST /users/login' do
    context 'when user present' do
      let!(:user) { User.create(data) }

      it 'returns status code 200' do
        post '/users/login', params: login_data
        expect(response).to have_http_status(200)
      end

      it 'response with auth token' do
        post '/users/login', params: login_data
        expect(parsed_response).to eq('auth_token' => create_token(user.id))
      end

      it 'returns status code 201 if password is wrong' do
        post '/users/login', params: login_data.merge(password: '12341234')
        expect(response).to have_http_status(401)
      end
    end
  end
end
