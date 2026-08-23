class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  def index; @categories = Category.order(:name); end
  def new; @category = Category.new; end
  def create
    @category = Category.new(category_params)
    if @category.save then redirect_to admin_categories_path, notice: "تمت إضافة التصنيف" else render :new, status: :unprocessable_entity end
  end
  def edit; end
  def update
    if @category.update(category_params) then redirect_to admin_categories_path, notice: "تم تحديث التصنيف" else render :edit, status: :unprocessable_entity end
  end
  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: "تم حذف التصنيف"
  end
  private
  def set_category; @category = Category.find(params[:id]); end
  def category_params; params.require(:category).permit(:name, :slug, :description, :image); end
end
