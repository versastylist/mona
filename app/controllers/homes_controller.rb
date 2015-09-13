class HomesController < ApplicationController
  def index
    if params[:search].present?
      users = User.search(params[:search])
    else
    end
  end
end
