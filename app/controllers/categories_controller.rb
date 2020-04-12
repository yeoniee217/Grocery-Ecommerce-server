class CategoriesController < ApplicationController
  def index
    # head 404
    @categories = Category.all
    render json: @categories
  end
end
