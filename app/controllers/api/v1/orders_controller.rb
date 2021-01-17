class Api::V1::OrdersController < ApplicationController
  skip_before_action :authenticate, only: []

  def user_orders
    
    orders = Order.where(user: @current_user)

    # ============================================================
    #            NEEDS TO SERIALIZE THE ARRAY OF RECORDS
    # ============================================================

    render json: each_serializer: orders
  end
end
