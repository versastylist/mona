class Admin::GlobalSettingsController < ApplicationController
  before_action :authenticate_admin!

  def update
    setting = GlobalSetting.instance
    if setting.update(global_params)
      flash[:success] = "Updated global settings"
    else
      flash[:warning] = "Didn't properly update"
    end

    redirect_to :back
  end

  private

  def global_params
    params.require(:global_setting).permit(:appointment_buffer)
  end
end
