class ProductsController < ApplicationController
  def by_category_id
    @products = Product.where("category_id = ?", params[:id])
    render json: @products
  end
end
