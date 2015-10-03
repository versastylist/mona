class UsersController < ApplicationController
  before_action :confirm_registration!, only: :show

  def show
    @user = User.from_params(params[:id])
  end

  def index
    @users = User.elastic_search(params[:query])
  end

  private

  def confirm_registration!
    if current_user.registration.nil?
      flash[:info] = 'Must finish registration before you can visit profile'
      redirect_to new_registration_path
    end
  end
end
