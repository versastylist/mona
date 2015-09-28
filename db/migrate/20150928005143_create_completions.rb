class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.integer :questionnaire_id, null: false
      t.string :user_id, null: false

      t.timestamps
    end
  end
end
