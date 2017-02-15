# frozen_string_literal: true
Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  resources :users, only: :create do
    collection do
      post 'login'
    end
  end

  resources :cart_items, only: [:index, :create, :destroy]
end
