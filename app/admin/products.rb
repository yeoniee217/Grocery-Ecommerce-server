ActiveAdmin.register Product do
  permit_params :num, :name, :description, :price, :stock_quantity, :discount, :category_id
end
