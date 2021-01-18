class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show, :filter_products]
  
  def index 
    products = Product.all
    render json: products
    # render json: {
    #   orders: products.map { |product|
    #     OrderSerializer.new(product).attributes
    #   }
    # }
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
    product = Product.create(
      name: params[:name], 
      price: params[:price], 
      quantity: params[:quantity].to_i,
      user: @current_user
    )
      
      if product.valid?  
        image = Cloudinary::Uploader.upload(params[:file])
        product[:image_url] = image["url"]
        product.save
        render json: { product: ProductSerializer.new(product) }, status: :created
      else 
        render json: { product: ProductSerializer.new(product) }, status: :bad_request
      end
  end

  def update
    byebug
  end

  def destroy 
    if @current_user
      product = Product.find_by(id: params[:id])
      product.destroy
      render json: { product: ProductSerializer.new(product), confirmation: "Product deleted successfully!" }, status: :accepted
    end
  end
end
