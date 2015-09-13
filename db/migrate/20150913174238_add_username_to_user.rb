class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :agree_to_terms, :boolean, default: false
  end
end
