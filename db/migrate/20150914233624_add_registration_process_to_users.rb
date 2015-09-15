class AddRegistrationProcessToUsers < ActiveRecord::Migration
  def change
    add_column :users, :registration_process, :string, default: "registration questions payment"
  end
end
