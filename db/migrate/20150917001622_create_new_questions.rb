class CreateNewQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :client_question, required: true
      t.string :stylist_question, required: true
      t.boolean :additional_info, required: true
      t.integer :questionnaire_id, required: true
    end
  end
end
