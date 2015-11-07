class CurrentSchedulesController < ApplicationController
  before_action :stylist_has_been_verified!
  before_action :verify_current_schedule!, only: [:new, :create]

  def new
    @schedule = Schedule.new
  end

  def edit
    @schedule = current_user.current_schedule
  end

  def update
    @schedule = current_user.current_schedule

    if @schedule.update(schedule_params)
      flash[:success] = "Successfully updated current schedule"
    end

    redirect_to stylist_path(current_user)
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
        :id,
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
