class CreateStylistReviews < ActiveRecord::Migration
  def change
    create_table :stylist_reviews do |t|
      t.integer :rating
      t.text :body
      t.integer :client_id, index: true, foreign_key: true
      t.integer :stylist_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
