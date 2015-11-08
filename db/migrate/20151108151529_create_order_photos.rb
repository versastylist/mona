class CreateOrderPhotos < ActiveRecord::Migration
  def change
    create_table :order_photos do |t|
      t.string :image
      t.string :description
      t.string :purpose
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
