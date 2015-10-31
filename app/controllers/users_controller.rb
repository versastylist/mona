class UsersController < ApplicationController
  before_action :confirm_registration!, only: :show
  before_action :authenticate_admin!, only: :ban

  def show
    @user = User.from_params(params[:id])
    @registration = @user.registration
    @future_appointments = @user.client_appointments.in_future.decorate
    @past_appointments = @user.client_appointments.in_past.decorate
    @cancelled_appointments = @user.client_appointments.cancelled.decorate
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
    if current_user.registration.nil?
      flash[:info] = 'Must finish registration before you can visit profile'
      redirect_to new_registration_path
    end
  end
end
