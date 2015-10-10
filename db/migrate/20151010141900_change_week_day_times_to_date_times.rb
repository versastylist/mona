class ChangeWeekDayTimesToDateTimes < ActiveRecord::Migration
  def change
    remove_column :week_days, :start_time, :time
    remove_column :week_days, :end_time, :time
    remove_column :week_days, :day_of_week, :date

    add_column :week_days, :start_time, :datetime
    add_column :week_days, :end_time, :datetime
    add_column :week_days, :day_of_week, :datetime
  end
end
