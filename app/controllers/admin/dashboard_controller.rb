class Admin::DashboardController < Admin::BaseController
  def index
    @products_count = Product.count
    @categories_count = Category.count
    @brands_count = Brand.count
    @featured_count = Product.featured.count
  end
end
