class CreateConfirmSubmittables < ActiveRecord::Migration
  def change
    create_table :confirm_submittables do |t|
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
