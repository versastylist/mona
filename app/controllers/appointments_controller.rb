class AppointmentsController < ApplicationController
  def new
    @stylist = User.find(params[:stylist_id])
    @available_appointments = AvailabilityChecker.new(
      @stylist, current_order.total_time
    ).find_times.to_json
  end

  def create
    @stylist = User.find(params[:stylist_id])
    @client = current_user
    @appointment = AppointmentBooker.new(
      client: @client,
      stylist: @stylist,
      order: @current_order,
      start: params[:start],
      end: params[:end],
    )
    if @appointment.book
      flash[:success] = "Successfully booked appointment"
    end
    redirect_to root_path
  end
end
