class AddCancelledByToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cancelled_by, :integer
  end
end
