class ChangeTimeIntervalToUseDatetime < ActiveRecord::Migration
  def change
    remove_column :time_intervals, :start_time, :time
    remove_column :time_intervals, :end_time, :time

    add_column :time_intervals, :start_time, :datetime
    add_column :time_intervals, :end_time, :datetime
  end
end
