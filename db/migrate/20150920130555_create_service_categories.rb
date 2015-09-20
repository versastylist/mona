class CreateServiceCategories < ActiveRecord::Migration
  def change
    create_table :service_categories do |t|
      t.string :name
      t.boolean :licence_required, default: false

      t.timestamps null: false
    end
  end
end
