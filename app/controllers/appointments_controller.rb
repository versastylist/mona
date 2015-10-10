class AppointmentsController < ApplicationController
  def new
    @stylist = User.find(params[:stylist_id])
    @available_appointments = AvailabilityChecker.new(@stylist, current_order.total_time).find_times
  end

  def create
  end
end
