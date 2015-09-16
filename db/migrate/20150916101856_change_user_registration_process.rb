class ChangeUserRegistrationProcess < ActiveRecord::Migration
  def change
    remove_column :users, :registration_process, :string
    remove_column :users, :registration_id, :integer
  end
end
