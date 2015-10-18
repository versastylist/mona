class AddAppointmentIdToTimeIntervals < ActiveRecord::Migration
  def change
    add_column :time_intervals, :appointment_id, :integer
  end
end
