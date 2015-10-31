class ClientsController < ApplicationController
  def index
    @stylist = User.find(params[:user_id])

    client_ids = @stylist.clients.pluck(:id).uniq

    if !params[:query].blank?
      @clients = User.search(
        params[:query],
        where: {
          id: client_ids
        }
      ).to_a
    else
      @clients = User.where(id: client_ids)
    end

    respond_to do |format|
      format.js { render json: @clients, each_serializer: UserSerializer }
    end
  end

  private

  def find_search_query
    params[:query].blank? ? '*' : params[:query]
  end
end
