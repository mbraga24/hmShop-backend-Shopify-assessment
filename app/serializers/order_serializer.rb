class OrderSerializer < ActiveModel::Serializer
  attributes :id, :product, :seller, :buyer
  # has_one :user
  # has_one :product

  def seller
    seller = User.find_by(id: object.product.user_id)
    return UserSerializer.new(seller)
  end

  def buyer
    buyer = object.user
    return UserSerializer.new(buyer)
  end

  def product 
    return {
      name: object.product.name,
      price: object.product.price,
      quantity: object.product.quantity,
      image_url: object.product.image_url
    }
  end
end
