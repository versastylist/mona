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
#  latitude   :float
#  longitude  :float
#
# Indexes
#
#  index_addresses_on_latitude_and_longitude  (latitude,longitude)
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
    it { should_not have_valid(:zip_code).when('skj343', '234') }
    it { should have_valid(:zip_code).when('02460') }
  end

  describe "#full_street_address" do
    it "returns a nicely formatted address for geocoder" do
      address = create(
        :address,
        address: "1 Congress St",
        appt_num: "#4",
        city: "Boston",
        state: "MA",
        zip_code: "02340",
      )

      expect(address.full_street_address).
        to eq "1 Congress St, #4, Boston, MA, 02340"
    end
  end

  describe "#location" do
    it "returns longitude and latitude" do
      address = create(:address)
      expect(address.location).to eq [address.latitude, address.longitude]
    end
  end
end
