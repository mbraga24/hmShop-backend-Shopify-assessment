class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate, only: [:create, :index]

  def index 
    products = Product.all

    render json: products
  end


  def create

  end


end
