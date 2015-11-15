require 'rails_helper'

describe GuestUser do
  let(:user) { described_class.new }

  describe "#authenticated?" do
    it "should always return false" do
      expect(user.authenticated?).to eq false
    end
  end

  describe "#completed_registration?" do
    it "should always return false" do
      expect(user.completed_registration?).to eq true
    end
  end

  describe "#admin?" do
    it "should always return false" do
      expect(user.admin?).to eq false
    end
  end

  describe "#has_seen_stylist?" do
    it "should always return false" do
      expect(user.has_seen_stylist?(1)).to eq false
    end
  end

  describe "#completed_survey?" do
    it "should always return false" do
      expect(user.completed_survey?).to eq false
    end
  end
end
