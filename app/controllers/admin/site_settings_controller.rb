class Admin::SiteSettingsController < Admin::BaseController
  def index
    @settings = SiteSetting.order(:key)
  end

  def edit
    @setting = SiteSetting.find(params[:id])
  end

  def update
    @setting = SiteSetting.find(params[:id])
    if @setting.update(setting_params)
      redirect_to admin_site_settings_path, notice: "تم تحديث الإعداد"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def setting_params; params.require(:site_setting).permit(:value); end
end
