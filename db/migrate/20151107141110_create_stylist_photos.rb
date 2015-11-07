class CreateStylistPhotos < ActiveRecord::Migration
  def change
    create_table :stylist_photos do |t|
      t.integer :stylist_id
      t.string :image

      t.timestamps null: false
    end
  end
end
