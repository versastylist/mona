class DropTypeColumnFromRegistrations < ActiveRecord::Migration
  def change
    remove_column :registrations, :type, :string
    remove_column :registrations, :timezone, :string
  end
end
