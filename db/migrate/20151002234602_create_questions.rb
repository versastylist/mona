class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.integer :survey_id, null: false
      t.integer :submittable_id
      t.string :submittable_type

      t.timestamps null: false
    end
  end
end
