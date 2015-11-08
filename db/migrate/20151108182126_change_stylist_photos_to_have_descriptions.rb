class ChangeStylistPhotosToHaveDescriptions < ActiveRecord::Migration
  def change
    add_column :stylist_photos, :description, :string
  end
end
