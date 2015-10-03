require 'rails_helper'

describe StylistDecorator do
  describe "#facebook_link" do
    it "returns facebook link if exists" do
      registration = create(:registration, facebook: "https://www.facebook.com/")
      stylist = create(:stylist, :with_registration, registration: registration)
      decorated = described_class.new(stylist)
      expect(decorated.facebook_link).to match(/facebook.com/)
    end

    it "returns nil if nothing exists" do
      stylist = create(:stylist, :with_registration)
      decorated = described_class.new(stylist)
      expect(decorated.facebook_link).to be_nil
    end
  end

  describe "#linked_in_link" do
    it "returns linkedin link if exists" do
      registration = create(:registration, linked_in: "https://www.linkedin.com/")
      stylist = create(:stylist, :with_registration, registration: registration)
      decorated = described_class.new(stylist)
      expect(decorated.linked_in_link).to match(/linkedin.com/)
    end

    it "returns nil if nothing exists" do
      stylist = create(:stylist, :with_registration)
      decorated = described_class.new(stylist)
      expect(decorated.linked_in_link).to be_nil
    end
  end
end