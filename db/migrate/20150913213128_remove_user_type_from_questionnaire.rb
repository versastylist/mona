class RemoveUserTypeFromQuestionnaire < ActiveRecord::Migration
  def up
    remove_column :questionnaires, :user_type
    change_column :questionnaires, :user_id, :integer, required: true
  end

  def down
    add_column :questionnaires, :user_type, :string, required: true
    change_column :questionnaires, :user_id, :integer
  end
end
