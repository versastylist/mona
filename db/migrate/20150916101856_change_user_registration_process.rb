class ChangeUserRegistrationProcess < ActiveRecord::Migration
  def change
    remove_column :users, :registration_process, :string
    add_column :users, :questionnaire_id, :integer
    add_column :users, :payment_info_id, :integer
  end
end
