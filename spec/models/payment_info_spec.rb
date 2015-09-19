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

require 'rails_helper'

RSpec.describe PaymentInfo, type: :model do
end
