class CategoriesController < ApplicationController
  def all_categories
    @categories = Category.all
    render json: @categories
  end
end
