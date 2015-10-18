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
    @week_day = WeekDay.find(params[:weekday_id])
    @appointment = AppointmentBooker.new(
      client: @client,
      stylist: @stylist,
      order: @current_order,
      start: params[:start],
      end: params[:end],
      week_day: @week_day
    )
    if @appointment.book
      session[:order_id] = nil
      flash[:success] = "Successfully booked appointment"
    end
    redirect_to root_path
  end

  def destroy
    @appointment = Appointment.find(params[:id])

    if @appointment.cancel!
      flash[:success] = "Successfully cancelled appointment"
    else
      flash[:danger] = "Was unable to cancel your appointment"
    end
    redirect_to :back
  end
end
