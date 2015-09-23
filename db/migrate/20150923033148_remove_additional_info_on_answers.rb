class RemoveAdditionalInfoOnAnswers < ActiveRecord::Migration
  def change
    remove_column :answers, :additional_info
  end
end
