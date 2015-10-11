class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.references :order, index: true, foreign_key: true
      t.integer :stylist_id, index: true, foreign_key: true
      t.integer :client_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
