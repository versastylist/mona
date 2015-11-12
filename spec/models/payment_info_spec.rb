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

require 'rails_helper'

RSpec.describe PaymentInfo, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "#gratuity_rate" do
    it "should default to 1 if none present" do
      info = build_stubbed(:payment_info, gratuity_rate: nil)
      expect(info.gratuity_rate).to eq 1
    end
  end

  describe "#save_with_payment" do
  end
end
