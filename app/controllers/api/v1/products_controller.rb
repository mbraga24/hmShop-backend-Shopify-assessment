class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate, only: [:index]
  # before_action :authenticate, only: [:create]

  def index 
    products = Product.all
    render json: products
  end


  def create
    # byebug
    image = Cloudinary::Uploader.upload(params[:file])
    # byebug
    product = Product.create(
      name: params[:name], 
      price: params[:price], 
      image_url: image["url"], 
      user: @current_user
    )
      render json: product
    end
end
