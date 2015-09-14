class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false
      t.string :avatar_url
      t.string :dob, null: false
      t.string :gender, null: false
      t.string :timezone, null: false
      t.string :facebook
      t.string :linked_in
      t.string :type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
