class AddBioToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :bio, :text
  end
end
