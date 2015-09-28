class CreateWeekDays < ActiveRecord::Migration
  def change
    create_table :week_days do |t|
      t.date :day_of_week, null: false
      t.time :start_time
      t.time :end_time
      t.integer :schedule_id
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
