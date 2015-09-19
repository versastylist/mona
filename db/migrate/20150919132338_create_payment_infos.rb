class CreatePaymentInfos < ActiveRecord::Migration
  def change
    create_table :payment_infos do |t|
      t.string :stripe_customer_token
      t.string :stripe_card_token
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
