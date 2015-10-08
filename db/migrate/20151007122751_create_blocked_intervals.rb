class CreateBlockedIntervals < ActiveRecord::Migration
  def change
    create_table :time_intervals do |t|
      t.string :title
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.references :week_day, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
