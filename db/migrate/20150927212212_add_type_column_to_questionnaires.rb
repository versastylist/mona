class AddTypeColumnToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :type, :integer, null: false
  end
end
