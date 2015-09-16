class ChangeRequiredQuestionnaireIdOnQuestion < ActiveRecord::Migration
  def change
    change_column :questions, :questionnaire_id, :integer, required: true
  end
end
