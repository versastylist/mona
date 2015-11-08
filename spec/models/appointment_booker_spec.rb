require 'rails_helper'

describe AppointmentBooker do
  describe "#book" do

  end

  describe "#interval_end_time" do
    let(:client) { create(:client) }
    let(:stylist) { create(:stylist) }

    it "should be normal end time if client has seen stylist" do
      Timecop.freeze(Time.local(2015, 11, 8, 10, 0)) do
        booker = described_class.new(client: client, stylist: stylist, end: DateTime.now.to_s)
        allow(client).to receive(:has_seen_stylist?).and_return(true)
        expect(booker.interval_end_time).to eq DateTime.now
      end
    end

    it "should add 15 minutes if this is clients first time seeing stylist" do
      Timecop.freeze(Time.local(2015, 11, 8, 10, 0)) do
        booker = described_class.new(client: client, stylist: stylist, end: DateTime.now.to_s)
        allow(client).to receive(:has_seen_stylist?).and_return(false)
        expect(booker.interval_end_time).to eq (DateTime.now + 15.minutes)
      end
    end
  end
end
