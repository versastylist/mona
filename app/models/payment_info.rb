# == Schema Information
#
# Table name: payment_infos
#
#  id                    :integer          not null, primary key
#  stripe_customer_token :string
#  stripe_card_token     :string
#  user_id               :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  stripe_bank_token     :string
#

class PaymentInfo < ActiveRecord::Base
  belongs_to :user

  def save_with_payment
    if user.client?
      customer = Stripe::Customer.create(
        description: "Created by VersaStylist on #{Date.today}",
        card: stripe_card_token,
        email: user.email
      )
    else
      customer = Stripe::Customer.create(
        description: "Created by VersaStylist on #{Date.today}",
        source: stripe_bank_token,
        email: user.email,
        full_name: user.full_name
      )
    end
    self.stripe_customer_token = customer.id
    save!
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your payment information."
    false
  end
end

