class ProductSerializer < ActiveModel::Serializer
  attributes :name, :price, :image_url
  has_one :user
end
