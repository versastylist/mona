class SchedulesController < ApplicationController
  before_action :stylist_has_been_verified!

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.stylist_id = current_user.id

    if @schedule.save
      redirect_to root_path, success: 'Success!'
    else
      redirect_to root_path, warning: 'Failure'
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(
      :name, :start_date, :end_date,
      week_days_attributes: [
        :day_of_week,
        :start_time,
        :end_time,
        :active,
        time_intervals_attributes: [
          :id,
          :title,
          :start_time,
          :end_time,
          :_destroy
        ]
      ]
    )
  end
end
