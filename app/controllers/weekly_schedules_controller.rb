class WeeklySchedulesController < ApplicationController
  before_action :stylist_has_been_verified!

  def new
    @schedule = WeeklySchedule.new
  end

  def create
    @schedule = WeeklySchedule.new(weekly_schedule_params)
    @schedule.stylist_id = current_user.id

    if @schedule.save
      redirect_to root_path, success: 'Success!'
    else
      redirect_to root_path, warning: 'Failure'
    end
  end

  private

  def weekly_schedule_params
    params.require(:weekly_schedule).permit(
      :name,
      week_days_attributes: [:day_of_week, :start_time, :end_time, :active]
    )
  end
end
