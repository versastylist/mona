class ChangeRegistrationDobColumn < ActiveRecord::Migration
  def change
    remove_column :registrations, :dob, :string
    add_column :registrations, :dob, :date
  end
end
