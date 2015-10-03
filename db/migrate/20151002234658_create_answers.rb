class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :completion_id, null: false
      t.integer :question_id, null: false
      t.string :text, null: false

      t.timestamps null: false
    end
  end
end
