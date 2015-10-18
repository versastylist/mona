class UsersController < ApplicationController
  before_action :confirm_registration!, only: :show

  def show
    @user = User.from_params(params[:id])
    @registration = @user.registration
    @future_appointments = @user.client_appointments.in_future.decorate
    @past_appointments = @user.client_appointments.in_past.decorate
    @cancelled_appointments = @user.client_appointments.cancelled.decorate
  end

  private

  def confirm_registration!
    if current_user.registration.nil?
      flash[:info] = 'Must finish registration before you can visit profile'
      redirect_to new_registration_path
    end
  end
end
