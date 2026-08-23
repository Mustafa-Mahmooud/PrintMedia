class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:products).order(:name)
  end

  def show
    @category = Category.find_by(id: params[:id]) || Category.find_by!(slug: params[:id])
    @products = @category.products.active.includes(:brand)
  end
end
