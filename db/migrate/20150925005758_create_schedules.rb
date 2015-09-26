class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :stylist_id, null: false
      t.string :state
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
