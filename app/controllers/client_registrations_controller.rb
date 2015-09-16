class ClientRegistrationsController < ApplicationController
  def new
    @address = Address.new
    @registration = ClientRegistration.new
  end

  # This should probably be refactored into Form Object if
  # any more complex logic gets added to the create action.
  def create
    @registration = ClientRegistration.new(registration_params)
    @registration.user = current_user
    @address = current_user.addresses.new(address_params)

    if @registration.save && @address.save
      # This should redirect to questionairre page not
      # once its ready and not user show page
      redirect_to user_path(current_user),
        success: "Successfully registered."
    else
      render "new"
    end
  end

  private

  def registration_params
    params.require(:client_registration).permit(
      :first_name,
      :last_name,
      :phone_number,
      :avatar,
      :dob,
      :gender,
      :timezone,
      :facebook,
      :linked_in
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
