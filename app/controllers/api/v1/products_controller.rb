class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show, :filter_products]
  # before_action :authenticate, only: [:create]
  
  def index 
    products = Product.all

    render json: products
  end

  def show
    product = Product.find_by(name: params[:name])

    render json: { product: ProductSerializer.new(product) }
  end

  def filter_products
    products = Product.where("lower(#{params[:type]}) like lower(?)", "%#{params[:query]}%")
    render json: products
  end

  def create
    image = Cloudinary::Uploader.upload(params[:file])
    product = Product.create(
      name: params[:name], 
      price: params[:price], 
      image_url: image["url"], 
      user: @current_user
    )
      render json: { product: ProductSerializer.new(product) }
    end
end
