class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def future
    @future_appointments = AppointmentDecorator.decorate_collection(
      Appointment.in_future.order(:start_time).page(params[:page]).per(50)
    )
  end

  def past
    @past_appointments = AppointmentDecorator.decorate_collection(
      Appointment.in_past.order(:start_time).page(params[:page]).per(50)
    )
  end

  def cancelled
    @cancelled_appointments = AppointmentDecorator.decorate_collection(
      Appointment.cancelled.order(:start_time).page(params[:page]).per(50)
    )
  end
end
