class AddBankTokenInfoToPaymentInfo < ActiveRecord::Migration
  def change
    add_column :payment_infos, :stripe_bank_token, :string
  end
end
