require 'rails_helper'

describe TempAddress do
  describe "#full_street_address" do
    it "returns a nicely formatted address for geocoder" do
      params =  {
        address: "1 Congress St",
        appt_num: "#4",
        city: "Boston",
        state: "MA",
        zip_code: "02340",
      }
      address = described_class.new(params)

      expect(address.full_street_address).
        to eq "1 Congress St, #4, Boston, MA, 02340"
    end
  end
end
