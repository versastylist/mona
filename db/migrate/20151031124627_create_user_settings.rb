class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :enable_booking, default: true
      t.boolean :multiple_services, default: false
      t.boolean :premium_membership, default: false
      t.boolean :booking_texts, default: false
      t.boolean :booking_emails, default: false
      t.boolean :verified, default: false
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
