class Admin::StylistsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if join_required?
      @stylists = User.stylists.joins(:registration).
        order("registrations.#{sort_by}").page(params[:page]).per(50)
    else
      @stylists = User.stylists.order(sort_by).page(params[:page]).per(50)
    end
  end

  def show
    @stylist = User.from_params(params[:id])

    @future_appointments = @stylist.stylist_appointments.in_future.decorate
    @past_appointments = @stylist.stylist_appointments.in_past.decorate
    @cancelled_appointments = @stylist.stylist_appointments.cancelled.decorate
  end

  private

  def join_required?
    ["first_name", "last_name"].include?(params[:sort])
  end

  def sort_by
    params[:sort].present? ? params[:sort].to_sym : :created_at
  end
end
