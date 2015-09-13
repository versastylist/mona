class CreateQuestionnaire < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.string :user_type
      t.integer :user_id
    end
  end
end
