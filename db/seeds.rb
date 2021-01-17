User.destroy_all
Product.destroy_all
Order.destroy_all

clark = User.create(
  first_name: "Clark",
  last_name: "Brown",
  email: "clark@example.com",
  password: "123123"
)

jacquelyn = User.create(
  first_name: "Jacquelyn",
  last_name: "Biantella",
  email: "jac@example.com",
  password: "123123"
)

product_1 = Product.create(
  name: "Jordan Shoes",
  price: "75.99",
  image_url: "https://di2ponv0v5otw.cloudfront.net/posts/2020/09/13/5f5ed24abcbb52dc282adab0/m_5f5fdb7ae131646464ec685f.jpg",
  user: clark
)

product_2 = Product.create(
  name: "MacBook Pro 2013",
  price: "650.00",
  image_url: "https://i.insider.com/596cf74fa47cb51c008b4b2f?width=1074&format=jpeg",
  user: clark
)

product_3 = Product.create(
  name: "Chic Womens Shiny Gold Pointy Toe Tassels Lace Up Low Heel Casual ",
  price: "39.99",
  image_url: "https://i.pinimg.com/474x/02/4c/bf/024cbf910e653ea3a1509733fdcf768a.jpg",
  user: jacquelyn
)

product_4 = Product.create(
  name: "Monogram Matelassé Leather Zip Pouch",
  price: "125.00",
  image_url: "https://image.s5a.com/is/image/saks/0400099508757_PEARLGREY?wid=480&hei=640&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0",
  user: jacquelyn
)

product_5 = Product.create(
  name: "Apple Iphone 7 - 128GB",
  price: "125.00",
  image_url: "https://cdn.shopify.com/s/files/1/0019/7387/8850/products/DSC01105_1aa7522e-35c6-4f47-8a8a-c11a1a7621fa_3456x.JPG?v=1542834895",
  user: jacquelyn
)

product_6 = Product.create(
  name: "Jordan Shoes - Semi new",
  price: "99.99",
  image_url: "https://di2ponv0v5otw.cloudfront.net/posts/2020/09/13/5f5ed24abcbb52dc282adab0/m_5f5fdb7ae131646464ec685f.jpg",
  user: jacquelyn
)

order_1 = Order.create(
  product: product_6, 
  user: clark
)

order_2 = Order.create(
  product: product_1, 
  user: jacquelyn
)

puts "Users Created: #{User.all.count} | Products Created: #{Product.all.count} | Orders Created: #{Order.all.count}"
puts "======================="
puts "      DATA SEEDED"
puts "======================="