class RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = Address.new
    @registration = Registration.new
  end

  # This should probably be refactored into Form Object if
  # any more complex logic gets added to the create action.
  def create
    @registration = current_user.build_registration(registration_params)
    @address = current_user.addresses.new(address_params)

    if @registration.save && @address.save
      # This should redirect to questionairre page not
      # once its ready and not user show page
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
      flash[:danger] = "Something went wrong updating your registration"
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
      :dob,
      :gender,
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
