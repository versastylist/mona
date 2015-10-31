class Admin::AppointmentsController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def future
    @future_appointments = Appointment.in_future.decorate
  end

  def past
    @past_appointments = Appointment.in_past.decorate
  end

  def cancelled
    @cancelled_appointments = Appointment.cancelled.decorate
  end
end
