class UsersController < ApplicationController
  def show
    @user = User.from_params(params[:id])
  end
end
