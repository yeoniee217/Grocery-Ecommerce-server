ActiveAdmin.register Product do
  permit_params :num, :name, :description, :price, :stock_quantity, :discount, :category_id, :image

  form do |f|
    f.semantic_errors # shows errors on :base
    f.object.num = Product.last.num + 1
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :image, as: :file
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
