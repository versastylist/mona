class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.from_params(params[:user_id])
    @address = Address.new
  end

  def edit
    @user = User.from_params(params[:user_id])
    @address = Address.find(params[:id])
  end

  def create
    @user = User.from_params(params[:user_id]).decorate
    @address = @user.addresses.new(address_params)

    if @address.save
      flash[:success] = "Successfully added address"
    end

    redirect_to @user.profile_path
  end

  def update
    @user = User.from_params(params[:user_id]).decorate
    @address = Address.find(params[:id])

    if address_params[:primary] == "true"
      @user.primary_address.update(primary: false)
      @address.update(address_params)
      redirect_to :back
    else
      if @address.update(address_params)
        flash[:success] = "Successfully updated address"
        redirect_to @user.profile_path
      else
        render 'edit'
      end
    end
  end

  private

  def address_params
    params.require(:address).permit(
      :primary,
      :address,
      :appt_num,
      :city,
      :state,
      :zip_code
    )
  end
end
