class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :user_id, null: false
      t.integer :service_menu_id, null: false

      t.timestamps null: false
    end
  end
end
