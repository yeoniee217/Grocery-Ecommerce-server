require "csv" # have to specify??

# OrderProduct.destroy_all
# Order.destroy_all
Product.destroy_all
# Customer.destroy_all
Category.destroy_all

categories_file = "vendor/data-source/categories.csv"
food_file = "vendor/data-source/food.csv"
home_living_file = "vendor/data-source/home-living.csv"
health_beauty_file = "vendor/data-source/health-beauty.csv"
pet_file = "vendor/data-source/pet-supplies.csv"
categories_json = CSV.read(categories_file, headers: true).map(&:to_hash)
foods_json = CSV.read(food_file, headers: true).map(&:to_hash)
home_living_json = CSV.read(home_living_file, headers: true).map(&:to_hash)
health_beauty_json = CSV.read(health_beauty_file, headers: true).map(&:to_hash)
pet_json = CSV.read(pet_file, headers: true).map(&:to_hash)

categories_json.each do |category_data|
  category = Category.create(name: category_data["primary-nav__list__item__link__text"])
  next unless category.persisted?
end

product_num = 1
food = Category.where(name: "Food").take
foods_json.each do |food_data|
  product = food.products.create(num:            product_num,
                                 name:           food_data["sr-only"],
                                 description:    food_data["product-name__item"],
                                 price:          food_data["price__value"].to_s.sub("$", "").to_i * 100,
                                 stock_quantity: Faker::Number.within(range: 1..70))
  product_num += 1
  next unless product.persisted?
end

home_living = Category.where(name: "Home & Living").take
home_living_json.each do |home_living_data|
  product = home_living.products.create(num:            product_num,
                                        name:           home_living_data["sr-only"],
                                        description:    home_living_data["product-name__item"],
                                        price:          home_living_data["price__value"].to_s.sub("$", "").to_i * 100,
                                        stock_quantity: Faker::Number.within(range: 1..70))
  product_num += 1
  next unless product.persisted?
end

health_beauty = Category.where(name: "Health & Beauty").take
health_beauty_json.each do |health_beauty_data|
  product = health_beauty.products.create(num:            product_num,
                                          name:           health_beauty_data["sr-only"],
                                          description:    health_beauty_data["product-name__item"],
                                          price:          health_beauty_data["price__value"].to_s.sub("$", "").to_i * 100,
                                          stock_quantity: Faker::Number.within(range: 1..70))
  product_num += 1
  next unless product.persisted?
end

pet = Category.where(name: "Pet Supplies").take
pet_json.each do |pet_data|
  product = pet.products.create(num:            product_num,
                                name:           pet_data["sr-only"],
                                description:    pet_data["product-name__item"],
                                price:          pet_data["price__value"].to_s.sub("$", "").to_i * 100,
                                stock_quantity: Faker::Number.within(range: 1..70))
  product_num += 1
  next unless product.persisted?
end

puts "Created #{Category.count} categories."
puts "Created #{Product.count} products."
# puts "Created #{Customer.count} customers."
# puts "Created #{Order.count} orders."
# puts "Created #{OrderProduct.count} OrderProducts."

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end
