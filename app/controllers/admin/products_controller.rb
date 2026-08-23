class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product.includes(:category, :brand).order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "تمت إضافة المنتج بنجاح"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "تم تحديث المنتج"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "تم حذف المنتج"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :slug, :model_number, :short_description, :description, :category_id, :brand_id, :active, :featured, :image)
  end
end
