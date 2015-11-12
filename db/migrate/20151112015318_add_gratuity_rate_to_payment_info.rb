class AddGratuityRateToPaymentInfo < ActiveRecord::Migration
  def change
    add_column :payment_infos, :gratuity_rate, :decimal, precision: 12, scale: 3, default: 0
  end
end
