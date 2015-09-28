class UsersController < ApplicationController
  def show
    @user = User.from_params(params[:id])
  end

  def index
    @users = User.elastic_search(params[:query])
  end
end
