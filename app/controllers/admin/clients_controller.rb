class Admin::ClientsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if join_required?
      @clients = User.clients.joins(:registration).
        order("registrations.#{sort_by}").page(params[:page]).per(30)
    else
      @clients = User.clients.order(sort_by).page(params[:page]).per(30)
    end
  end

  def show
    @client = User.from_params(params[:id])

    @future_appointments = @client.client_appointments.in_future.decorate
    @past_appointments = @client.client_appointments.in_past.decorate
    @cancelled_appointments = @client.client_appointments.cancelled.decorate
  end

  private

  def join_required?
    ["first_name", "last_name"].include?(params[:sort])
  end

  def sort_by
    params[:sort].present? ? params[:sort].to_sym : :created_at
  end
end
