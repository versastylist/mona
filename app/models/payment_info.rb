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
#  gratuity_rate         :decimal(12, 3)   default(0.0)
#

class PaymentInfo < ActiveRecord::Base
  GRATUITY_OPTIONS = [
    ["0%", 0],
    ["10%", 0.1],
    ["15%", 0.15],
    ["20%", 0.2],
    ["25%", 0.25],
    ["30%", 0.3],
  ]
  belongs_to :user

  def save_with_payment
    if user.client?
      customer = Stripe::Customer.create(
        description: "Created by VersaStylist on #{Date.today}",
        card: stripe_card_token,
        email: user.email
      )
    else
      Rails.logger.error("stripe token was: #{stripe_bank_token}")
      customer = Stripe::Customer.create(
        description: "Created by VersaStylist on #{Date.today}",
        source: stripe_bank_token,
        email: user.email,
      )
    end
    self.stripe_customer_token = customer.id
    save!
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your payment information.  Please verify your credentials."
    false
  end

  # TODO: Ask ricky what default gratuity rate should be... I'm guessing 0
  def gratuity_rate
    self[:gratuity_rate] || 0
  end
end

