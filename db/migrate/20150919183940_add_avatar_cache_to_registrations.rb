class AddAvatarCacheToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :avatar_cache, :string
  end
end
