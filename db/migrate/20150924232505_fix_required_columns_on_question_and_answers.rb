class FixRequiredColumnsOnQuestionAndAnswers < ActiveRecord::Migration
  def change
    change_column :questions, :client_question, :string, null: false
    change_column :questions, :stylist_question, :string, null: false
    change_column :questions, :questionnaire_id, :integer, null: false

    change_column :answers, :user_type, :integer, null: false
    change_column :answers, :answer, :boolean, null: false
    change_column :answers, :user_id, :integer, null: false
    change_column :answers, :question_id, :integer, null: false
  end
end
