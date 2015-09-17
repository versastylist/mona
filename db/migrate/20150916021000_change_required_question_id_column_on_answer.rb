class ChangeRequiredQuestionIdColumnOnAnswer < ActiveRecord::Migration
  def change
    change_column :answers, :question_id, :integer, required: true
  end
end
