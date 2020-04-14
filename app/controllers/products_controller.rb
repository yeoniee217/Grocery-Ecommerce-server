class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    render :show
  end

  def by_category_id
    @products = Product.where("category_id = ?", params[:id])
    @category = Category.find(params[:id])
    render :by_category_id
    # render json: @products
  end
  # After action, automatically renders the by_category_id.json.jbuilder
  # The jbuilder view will get access to the @products array.

  def on_sale
    @products = Product.where("category_id = ? AND discount IS NOT NULL", params[:id])
    render :by_category_id
  end

  def new
    @products = Product.where("category_id = ? AND created_at >= ?", params[:id], 3.days.ago)
    render :by_category_id
  end

  def recently_updated
    @products = Product.where("category_id = ? AND updated_at >= ?", params[:id], 3.days.ago)
    render :by_category_id
  end

  def search
    puts "hello"
    puts params
    if params[:categoryID] == "0"
      @products = Product.where("name LIKE ?", "%#{params[:keyword]}%")
      # @category_name = "All"
    else
      @products = Product.where("category_id = ? AND name LIKE ?", params[:categoryID], "%#{params[:keyword]}%")
      # @category_name = Category.find(params[:categoryID]).name
    end
    render :search
  end
end
