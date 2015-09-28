class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.boolean :primary, default: false
      t.integer :user_id, null: false
      t.string :address, null: false
      t.string :zip_code, null: false
      t.string :state, null: false
      t.string :appt_num
      t.string :city, null: false

      t.timestamps null: false
    end
  end
end
