class FutureSchedulesController < ApplicationController
  before_action :stylist_has_been_verified!
  before_action :verify_future_schedule!, only: [:new, :create]

  def new
    if current_user.current_schedule
      @day_to_start = current_user.current_schedule.days_until_over
      @schedule_week_one = ((@day_to_start + 1)..(@day_to_start + 7)).map { |n| n.days.from_now }
      @schedule_week_two = ((@day_to_start + 8)..(@day_to_start + 14)).map { |n| n.days.from_now }
      @schedule = Schedule.new
    else
      redirect_to :back,
        warning: "Create a current schedule first!"
    end
  end

  def edit
    @schedule = current_user.future_schedule
  end

  def update
    @schedule = current_user.future_schedule

    if @schedule.update(schedule_params)
      flash[:success] = "Successfully updated future schedule"
    end

    redirect_to stylist_path(current_user)
  end

  def create
    @schedule = current_user.schedules.new(schedule_params.merge(state: 'future'))

    if @schedule.save
      flash[:success] = 'Successfully created schedule'
    else
      flash[:warning] = 'Something went wrong saving your schedule'
    end
    redirect_to stylist_path(current_user)
  end

  private

  def verify_future_schedule!
    if current_user.future_schedule.present?
      flash[:warning] = "You already have a future schedule!"
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
