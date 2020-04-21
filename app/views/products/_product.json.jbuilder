json.extract! product, :id, :num, :name, :description, :price, :stock_quantity,
              :discount, :created_at, :updated_at
json.imageUrl "http://localhost:3000" + url_for(product.image)

json.category do
  json.id product.category.id
  json.name product.category.name
end
