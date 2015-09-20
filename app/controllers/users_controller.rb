class UsersController < ApplicationController
  before_action :verify_complete_registration!, only: :show

  def show
    @user = User.from_params(params[:id])
  end

  def index
    @users = User.elastic_search(params[:query])
  end

  private

  def verify_complete_registration!
    unless current_user.completed_registration?
      flash[:warning] = "Make sure to complete your registration!"
      redirect_to current_user.next_registration_step
    end
  end
end
