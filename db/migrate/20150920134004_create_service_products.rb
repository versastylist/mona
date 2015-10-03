class CreateServiceProducts < ActiveRecord::Migration
  def change
    create_table :service_products do |t|
      t.string :name, null: false
      t.integer :minute_duration, null: false
      t.integer :hours
      t.integer :minutes
      t.decimal :price, precision: 8, scale: 2, null: false
      t.text :details
      t.text :preparation_instructions
      t.boolean :displayed, default: true
      t.integer :service_id, null: false

      t.timestamps null: false
    end
  end
end