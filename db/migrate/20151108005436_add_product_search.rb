class AddProductSearch < ActiveRecord::Migration
  def change
    create_table :product_searches do |t|
      t.string :term
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
