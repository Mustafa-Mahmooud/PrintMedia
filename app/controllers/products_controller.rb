class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    @products = Product.active.includes(:category, :brand).order(created_at: :desc)
    @products = @products.where(category_id: params[:category]) if params[:category].present?
    @products = @products.where("name LIKE ? OR short_description LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") if params[:q].present?
  end

  def show
    @product = Product.active.includes(:category, :brand, :product_images).find_by(id: params[:id]) || Product.active.includes(:category, :brand, :product_images).find_by!(slug: params[:id])
  end
end
