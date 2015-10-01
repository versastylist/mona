class DropQuestionnaireTables < ActiveRecord::Migration
  def change
    drop_table :questionnaires
    drop_table :questions
    drop_table :answers
  end
end
