class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.from_params(params[:user_id])
    @address = Address.find(params[:id])

    if address_params[:primary] == "true"
      @user.primary_address.update(primary: false)
      @address.update(address_params)
    else
      @address.update(address_params)
    end
    redirect_to :back
  end

  private

  def address_params
    params.require(:address).permit(:primary)
  end
end
