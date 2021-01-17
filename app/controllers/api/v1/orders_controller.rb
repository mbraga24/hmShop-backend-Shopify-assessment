class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  def index
    orders = Order.all
    render json: orders
  end

  def user_orders
    orders = Order.where(user: @current_user)
    render json: {
      orders: orders.map { |order|
        OrderSerializer.new(order).attributes
      }
    }
  end
end
