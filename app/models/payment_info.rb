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
#

class PaymentInfo < ActiveRecord::Base
  belongs_to :user

  def save_with_payment
    customer = Stripe::Customer.create(
      description: user.email,
      card: stripe_card_token
    )
    self.stripe_customer_token = customer.id
    save!
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
