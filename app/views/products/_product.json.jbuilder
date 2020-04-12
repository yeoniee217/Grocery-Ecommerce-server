json.extract! product, :id, :num, :name, :description, :price, :stock_quantity,
              :discount, :created_at, :updated_at
json.imageUrl "http://localhost:3000" + url_for(product.image)

json.category_name product.category.name
