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
      expect(user.completed_registration?).to eq false
    end
  end
end
