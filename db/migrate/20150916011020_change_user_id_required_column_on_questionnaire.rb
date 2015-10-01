class ChangeUserIdRequiredColumnOnQuestionnaire < ActiveRecord::Migration
  def change
    change_column :questionnaires, :user_id, :integer, required: true
  end
end
