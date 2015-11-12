class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 12, scale: 3
      t.decimal :tax, precision: 12, scale: 3
      t.decimal :total, precision: 12, scale: 3
      t.string :state, default: 'pending'
      t.integer :gratuity
      t.datetime :cancelled_at
      t.datetime :authorized_at
      t.datetime :captured_at

      t.timestamps null: false
    end
  end
end
