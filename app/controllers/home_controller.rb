class HomeController < ApplicationController
  def index
    @categories = Category.order(:name).limit(4)
    @featured_products = Product.active.featured.includes(:category, :brand).limit(4)
  end
end
