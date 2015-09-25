class CreateWeekDays < ActiveRecord::Migration
  def change
    create_table :week_days do |t|
      t.string :day_of_week, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.integer :weekly_schedule_id
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
