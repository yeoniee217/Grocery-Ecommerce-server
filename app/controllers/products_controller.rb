class ProductsController < ApplicationController
  def by_category_id
    @products = Product.where("category_id = ?", params[:id])
    render :by_category_id
    # render json: @products
  end
  # After action, automatically renders the by_category_id.json.jbuilder
  # The jbuilder view will get access to the @products array.
end
