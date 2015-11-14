class UsersController < ApplicationController
  before_action :confirm_registration!, only: :show
  before_action :authorize_user_show, only: :show
  before_action :authenticate_admin!, only: :ban

  def show
    @user = User.from_params(params[:id])
    @registration = @user.registration
    @future_appointments = @user.client_appointments.in_future.decorate
    @past_appointments = @user.client_appointments.in_past.decorate
    @cancelled_appointments = @user.client_appointments.cancelled.decorate
    @completion = @user.registration_survey

    if current_user.authenticated?
      @addresses = current_user.addresses.order(primary: :desc).decorate
    end
  end

  def ban
    @user = User.from_params(params[:id])

    if @user.update(banned: true)
      # Should probably send a banned email to the user.
      flash[:success] = "Successfully banned user"
    else
      flash[:warning] = "Ban didn't work"
    end
    redirect_to :back
  end

  private

  def confirm_registration!
    return true if current_user.admin?
    if current_user.registration.nil?
      flash[:info] = 'Must finish registration before you can visit profile'
      redirect_to new_registration_path
    end
  end

  def authorize_user_show
    return true if current_user.admin?
    user = User.from_params(params[:id])
    return true if current_user == user

    if current_user.stylist?
      if user.has_seen_stylist?(current_user)
        return true
      else
        flash[:warning] = "Link no longer available"
        redirect_to stylist_path(current_user)
      end
    else
      redirect_to menu_filters_path
    end
  end
end
