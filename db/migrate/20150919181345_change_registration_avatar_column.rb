class ChangeRegistrationAvatarColumn < ActiveRecord::Migration
  def change
    remove_column :registrations, :avatar_url, :string
    add_column :registrations, :avatar, :string
  end
end
