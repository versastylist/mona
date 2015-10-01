class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.boolean :value, required: true
      t.string :additional_info
      t.integer :question_id, required: true
    end
  end
end
