class ClientRegistrationsController < ApplicationController
  def new
    @registration = ClientRegistration.new
  end

  def create
    @registration = ClientRegistration.new(registration_params)
    @registration.user = current_user
    if @registration.save
      # This should redirect to questionairre page 
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
end
