# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string           not null
#  agree_to_terms         :boolean          default(FALSE)
#  role                   :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context "associations" do
    it { should have_one(:registration) }
    it { should have_one(:payment_info) }
    it { should have_one(:primary_address) }
    it { should have_many(:addresses) }
    it { should have_many(:services) }
    it { should have_many(:service_products).through(:services) }
    it { should have_many(:service_menus).through(:services) }
    it { should have_many(:schedules) }
    it { should have_one(:current_schedule) }
    it { should have_one(:future_schedule) }
  end

  context "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should have_valid(:username).when('apple') }
    it { should_not have_valid(:username).when('a', '', 1, 'with space') }
    it { should validate_presence_of(:agree_to_terms) }
    it { should have_valid(:role).when('client', 'stylist', 'admin') }
    it { should_not have_valid(:role).when('', nil, 'super user') }
  end

  describe "#completed_registration?" do
    it "should return true if registration process is empty" do
      client = create(:client, :with_registration)
      stylist = create(:stylist, :with_registration)
      expect(client.completed_registration?).to eq true
      expect(stylist.completed_registration?).to eq true
    end

    it "should return false for a freshly created user" do
      client = create(:client)
      expect(client.completed_registration?).to eq false
    end
  end

  describe "#stylist?" do
    it "returns true if user is a stylist" do
      stylist = build_stubbed(:stylist)
      expect(stylist.stylist?).to eq true
    end

    it "returns false if user is not a stylist" do
      client = build_stubbed(:client)
      expect(client.stylist?).to eq false
    end
  end

  describe "#client?" do
    it "returns true if user is a client" do
      client = build_stubbed(:client)
      expect(client.client?).to eq true
    end

    it "returns false if user is not a client" do
      stylist = build_stubbed(:stylist)
      expect(stylist.client?).to eq false
    end
  end

  describe "#to_param" do
    it "returns id if client" do
      client = build_stubbed(:client)
      expect(client.to_param).to eq client.id.to_s
    end

    it "returns username if stylist" do
      stylist = build_stubbed(:stylist, username: 'the-tiger')
      expect(stylist.to_param).to eq 'the-tiger'
    end
  end

  describe "#authenticated?" do
    it "always returns true" do
      client = build_stubbed(:client)
      expect(client.authenticated?).to eq true
    end
  end

  describe "#registration_survey" do
    it "returns true if user is an admin" do
      admin = build_stubbed(:admin)
      expect(admin.registration_survey).to eq true
    end

    it "returns completion object for the registration survey if it exists" do
      client = create(:client)
      survey = create(:survey, title: 'Client Registration')
      completion = create(:completion, user: client, survey: survey)
      expect(client.registration_survey).to eq completion
    end

    it "also works for stylists" do
      stylist = create(:stylist)
      survey = create(:survey, title: 'Stylist Registration')
      completion = create(:completion, user: stylist, survey: survey)
      expect(stylist.registration_survey).to eq completion
    end
  end
end
