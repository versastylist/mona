class ChangeTypeColumnOnQuestionnaires < ActiveRecord::Migration
  def change
    rename_column :questionnaires, :type, :questionnaire_type
  end
end
