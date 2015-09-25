class WeeklySchedulesController < ApplicationController
  def new
    @schedule = WeeklySchedule.new
  end

  def create
    @schedule = WeeklySchedule.new(weekly_schedule_params)
    @schedule.stylist_id = current_user.id

    if @schedule.save
      redirect_to root_path, success: 'Success!'
    end
  end

  private

  def weekly_schedule_params
    params.require(:weekly_schedule).permit(
      :name,
      week_days_attributes: [:day_of_week, :start_time, :end_time]
    )
  end
end
