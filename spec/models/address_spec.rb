# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  primary    :boolean          default(FALSE)
#  user_id    :integer          not null
#  address    :string           not null
#  zip_code   :string           not null
#  state      :string           not null
#  appt_num   :string
#  city       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Address, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:primary) }
  end
end
