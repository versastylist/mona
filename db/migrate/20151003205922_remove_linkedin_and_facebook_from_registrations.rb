class RemoveLinkedinAndFacebookFromRegistrations < ActiveRecord::Migration
  def change
    remove_column :registrations, :facebook, :string
    remove_column :registrations, :linked_in, :string
  end
end
