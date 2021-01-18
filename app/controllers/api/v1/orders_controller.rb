class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  def index
    orders = Order.all
    render json: orders
  end

  def create 
    product = Product.find_by(id: params[:product_id])
    order = Order.create( user: @current_user, product: product )

    if order.valid?
      render json: { order: OrderSerializer.new(order) }, status: :created
    else
      render json: { header: "Something went wrong. Please try again later." }, status: :bad_request
    end
  end

  # ======================================================
  #                     FAKE PURCHASE
  # ======================================================
  def place_order
    orders = params[:orders]

    orders.each do |o|
      order = Order.find_by(id: o)
      product = order.product 

      if product.quantity > 0
        product.decrement(:quantity)
        product.save
      end
      order.destroy
    end

    render json: { orders: orders }
  end

  def user_orders
    orders = Order.where(user: @current_user)
    render json: {
      orders: orders.map { |order|
        OrderSerializer.new(order).attributes
      }
    }
  end

  def destroy
    order = Order.find_by(id: params[:id])
    if order.destroy
      render json: { order: OrderSerializer.new(order), confirmation: "Your order has been cancelled successfully!" }, status: :ok
    else
      head(:unprocessable_entity)
    end
  end
end
