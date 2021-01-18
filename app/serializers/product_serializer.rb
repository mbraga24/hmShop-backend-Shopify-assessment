class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :image_url
  has_one :user
end
