class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show, :filter_products]
  # before_action :authenticate, only: [:create]
  
  def index 
    products = Product.all
    render json: products
  end

  def show
    product = Product.find_by(name: params[:name])
    render json: { product: ProductSerializer.new(product) }, statu: :ok
  end

  def filter_products
    products = Product.where("lower(#{params[:type]}) like lower(?)", "%#{params[:query]}%")
    render json: products, status: :ok
  end

  def create
    image = Cloudinary::Uploader.upload(product_params[:file])
    product = Product.create(
      name: product_params[:name], 
      price: product_params[:price], 
      image_url: image["url"], 
      user: @current_user
    )
      render json: { product: ProductSerializer.new(product) }, status: :created
  end

  def destroy 
    if @current_user
      product = Product.find_by(id: params[:id])
      product.destroy
      render json: { product: ProductSerializer.new(product), confirmation: "Product deleted successfully!" }, status: :accepted
    end
  end


  private 

  def product_params
    params.require(:product).permit(:name, :price, :file)
  end
end
