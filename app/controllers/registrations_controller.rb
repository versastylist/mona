class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = Address.new
    @registration = Registration.new
  end

  def create
    @registration = current_user.build_registration(registration_params)
    @registration.dob = Date.new(params['registration']['dob(1i)'].to_i,params['registration']['dob(2i)'].to_i,params['registration']['dob(3i)'].to_i)
    @address = current_user.addresses.new(address_params)

    if @registration.save && @address.save
      flash[:success] = "Successfully registered."
      redirect_to new_payment_info_path
    else
      render "new"
    end
  end

  def update
    @registration = current_user.registration
    if @registration.update_attributes(registration_params)
      flash[:success] = "Updated registration details"
    else
      flash[:danger] = @registration.errors.full_messages.join(', ')
    end
    redirect_to :back
  end

  private

  def registration_params
    params.require(:registration).permit(
      :first_name,
      :last_name,
      :phone_number,
      :avatar,
      :gender,
      :bio,
    )
  end

  def address_params
    params.require(:address).permit(
      :address,
      :appt_num,
      :city,
      :zip_code,
      :state,
      :primary
    )
  end
end
