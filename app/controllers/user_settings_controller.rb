class UserSettingsController < ApplicationController
  def update
    @user = User.from_params(params[:user_id])

    if @user.settings.update(user_settings_params)
      respond_to do |format|
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.json { render json: @user.errors.full_messages }
      end
    end
  end

  def user_settings_params
    params.require(:user_settings).permit(
      :enable_booking,
      :multiple_services,
      :booking_texts,
      :booking_emails,
    )
  end
end
