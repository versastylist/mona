class RemoveColumnOnQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :additional_info
  end
end
