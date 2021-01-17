class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :image_url
  has_one :user
end
