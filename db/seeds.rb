# frozen_string_literal: true

require "csv" # have to specify??
require "faker"
# require "open-uri"

Province.destroy_all
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

provinces = [
  { name: "Ontario", abbrev: "ON", GST_rate: nil, PST_rate: nil, HST_rate: 0.13 },
  { name: "Quebec", abbrev: "QC", GST_rate: 0.05, PST_rate: 0.09975, HST_rate: nil },
  { name: "Nova Scotia", abbrev: "NS", GST_rate: nil, PST_rate: nil, HST_rate: 0.15 },
  { name: "New Brunswick", abbrev: "NB", GST_rate: nil, PST_rate: nil, HST_rate: 0.15 },
  { name: "Manitoba", abbrev: "MB", GST_rate: 0.05, PST_rate: 0.07, HST_rate: nil },
  { name: "British Columbia", abbrev: "BC", GST_rate: 0.05, PST_rate: 0.07, HST_rate: nil },
  { name: "Prince Edward Island", abbrev: "PE", GST_rate: nil, PST_rate: nil, HST_rate: 0.15 },
  { name: "Saskatchewan", abbrev: "SK", GST_rate: 0.05, PST_rate: 0.06, HST_rate: nil },
  { name: "Alberta", abbrev: "AB", GST_rate: 0.05, PST_rate: nil, HST_rate: nil },
  { name: "Newfoundland and Labrador", abbrev: "NL", GST_rate: nil, PST_rate: nil, HST_rate: 0.15 },
  { name: "Northwest Territories", abbrev: "NT", GST_rate: 0.05, PST_rate: nil, HST_rate: nil },
  { name: "Yukon", abbrev: "YT", GST_rate: 0.05, PST_rate: nil, HST_rate: nil },
  { name: "Nunavut", abbrev: "NU", GST_rate: 0.05, PST_rate: nil, HST_rate: nil }
]

# creating provinces
provinces.each do |province|
  Province.create(name: province[:name], abbrev: province[:abbrev], GST_rate: province[:GST_rate],
                  PST_rate: province[:PST_rate], HST_rate: province[:HST_rate])
end

# creating categories
categories_json.each do |category_data|
  category = Category.create(name: category_data["primary-nav__list__item__link__text"])
  next unless category.persisted?
end

# creating products for Food category
product_num = 1
food = Category.where(name: "Food").take
foods_json.each do |food_data|
  product = food.products.create(num:            product_num,
                                 name:           food_data["sr-only"],
                                 description:    Faker::Hipster.paragraph_by_chars(characters: 220, supplemental: false),
                                 price:          (food_data["price__value"].to_d * 100).to_i,
                                 stock_quantity: Faker::Number.within(range: 1..70))
  downloaded_image = open(food_data["responsive-image src"])
  product.image.attach(
    io:           downloaded_image,
    filename:     food_data["responsive-image src"].split("/")[-1],
    content_type: "image/jpg"
  )
  product_num += 1
  next unless product.persisted?
end

# creating products for Home & Living category
home_living = Category.where(name: "Home & Living").take
home_living_json.each do |home_living_data|
  product = home_living.products.create(num:            product_num,
                                        name:           home_living_data["sr-only"],
                                        description:    Faker::Hipster.paragraph_by_chars(characters: 220, supplemental: false),
                                        price:          (home_living_data["price__value"].to_d * 100).to_i,
                                        stock_quantity: Faker::Number.within(range: 1..70))
  downloaded_image = open(home_living_data["responsive-image src"])
  product.image.attach(
    io:           downloaded_image,
    filename:     home_living_data["responsive-image src"].split("/")[-1],
    content_type: "image/jpg"
  )
  product_num += 1
  next unless product.persisted?
end

# creating products for Health & Beauty category
health_beauty = Category.where(name: "Health & Beauty").take
health_beauty_json.each do |health_beauty_data|
  product = health_beauty.products.create(num:            product_num,
                                          name:           health_beauty_data["sr-only"],
                                          description:    Faker::Hipster.paragraph_by_chars(characters: 220, supplemental: false),
                                          price:          (health_beauty_data["price__value"].to_d * 100).to_i,
                                          stock_quantity: Faker::Number.within(range: 1..70))
  downloaded_image = open(health_beauty_data["responsive-image src"])
  product.image.attach(
    io:           downloaded_image,
    filename:     health_beauty_data["responsive-image src"].split("/")[-1],
    content_type: "image/jpg"
  )
  product_num += 1
  next unless product.persisted?
end

# creating products for Pet Supplies category
pet = Category.where(name: "Pet Supplies").take
pet_json.each do |pet_data|
  product = pet.products.create(num:            product_num,
                                name:           pet_data["sr-only"],
                                description:    Faker::Hipster.paragraph_by_chars(characters: 220, supplemental: false),
                                price:          (pet_data["price__value"].to_d * 100).to_i,
                                stock_quantity: Faker::Number.within(range: 1..70))
  downloaded_image = open(pet_data["responsive-image src"])
  product.image.attach(
    io:           downloaded_image,
    filename:     pet_data["responsive-image src"].split("/")[-1],
    content_type: "image/jpg"
  )
  product_num += 1
  next unless product.persisted?
end

puts "Created #{Province.count} provinces."
puts "Created #{Category.count} categories."
puts "Created #{Product.count} products."
# puts "Created #{Customer.count} customers."
# puts "Created #{Order.count} orders."
# puts "Created #{OrderProduct.count} OrderProducts."

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
# end
