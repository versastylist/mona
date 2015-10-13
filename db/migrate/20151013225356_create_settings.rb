class CreateSettings < ActiveRecord::Migration
  def change
    create_table :global_settings do |t|
      t.integer :appointment_buffer

      t.timestamps null: false
    end
  end
end
