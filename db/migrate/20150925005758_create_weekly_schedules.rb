class CreateWeeklySchedules < ActiveRecord::Migration
  def change
    create_table :weekly_schedules do |t|
      t.integer :stylist_id, null: false

      t.timestamps null: false
    end
  end
end
