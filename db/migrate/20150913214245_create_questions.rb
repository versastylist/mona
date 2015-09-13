class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body, required: true
      t.integer :questionnaire_id, required: true
    end
  end
end
