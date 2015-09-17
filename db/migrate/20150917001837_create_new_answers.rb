class CreateNewAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_type, required: true
      t.boolean :answer, required: true
      t.string :additional_info
      t.integer :user_id, required: true
      t.integer :question_id, required: true
    end
  end
end
