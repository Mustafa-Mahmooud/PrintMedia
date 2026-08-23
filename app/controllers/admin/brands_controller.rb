class Admin::BrandsController < Admin::BaseController
  before_action :set_brand, only: %i[edit update destroy]
  def index; @brands = Brand.order(:name); end
  def new; @brand = Brand.new; end
  def create
    @brand = Brand.new(brand_params)
    if @brand.save then redirect_to admin_brands_path, notice: "تمت إضافة العلامة" else render :new, status: :unprocessable_entity end
  end
  def edit; end
  def update
    if @brand.update(brand_params) then redirect_to admin_brands_path, notice: "تم تحديث العلامة" else render :edit, status: :unprocessable_entity end
  end
  def destroy
    @brand.destroy
    redirect_to admin_brands_path, notice: "تم حذف العلامة"
  end
  private
  def set_brand; @brand = Brand.find(params[:id]); end
  def brand_params; params.require(:brand).permit(:name, :slug); end
end
