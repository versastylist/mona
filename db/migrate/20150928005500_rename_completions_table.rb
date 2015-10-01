class RenameCompletionsTable < ActiveRecord::Migration
  def change
    rename_table :completions, :questionnaire_completions
  end
end
