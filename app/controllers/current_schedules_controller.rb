class CurrentSchedulesController < ApplicationController
  before_action :stylist_has_been_verified!
  before_action :verify_current_schedule!

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = current_user.schedules.new(schedule_params.merge(state: 'current'))

    if @schedule.save
      flash[:success] = 'Successfully created schedule'
    else
      flash[:warning] = 'Something went wrong saving your schedule'
    end
    redirect_to stylist_path(current_user)
  end

  private

  def verify_current_schedule!
    if current_user.current_schedule.present?
      flash[:warning] = "You already have a current schedule!"
      redirect_to stylist_path(current_user)
    end
  end

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
