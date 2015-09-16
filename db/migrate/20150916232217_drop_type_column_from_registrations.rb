class DropTypeColumnFromRegistrations < ActiveRecord::Migration
  def change
    remove_column :registrations, :type, :string
  end
end
