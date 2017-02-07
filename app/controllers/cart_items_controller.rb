# frozen_string_literal: true
class CartItemsController < ApplicationController
  include Authentication

  def index
    json_response(@current_user.products)
  end

  def create
    if params[:product_id] && product = Product.find(params[:product_id])
      @current_user.add(product)
      # response w/ users product list each time to prevent oudated data in case simultaneous using several devices
      json_response(@current_user.products)
    else
      json_response({ error: 'unknown product' }, status: :bad_request)
    end
  end

  def delete
    if params[:product_id] && product = Product.find(params[:product_id])
      @current_user.delete(product)
      # response w/ users product list each time to prevent oudated data in case simultaneous using several devices
      json_response(@current_user.products)
    else
      json_response({ error: 'unknown product' }, status: :bad_request)
    end
  end
end
