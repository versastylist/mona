class AddRegistrationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_id, :integer
  end
end
