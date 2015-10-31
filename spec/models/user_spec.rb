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
#  settings               :jsonb            default({}), not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
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
    it { should have_many(:stylist_appointments) }
    it { should have_many(:client_appointments) }
    it { should have_many(:addresses) }
    it { should have_many(:services) }
    it { should have_many(:service_products).through(:services) }
    it { should have_many(:service_menus).through(:services) }
    it { should have_many(:schedules) }
    it { should have_one(:current_schedule) }
    it { should have_one(:future_schedule) }
    it { should have_many(:stylist_reviews) }
    it { should have_many(:client_reviews) }
    it { should have_many(:stylist_appointments) }
    it { should have_many(:client_appointments) }
    it { should have_many(:clients).through(:stylist_appointments) }
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

  describe "#has_seen_stylist?" do
    let(:stylist) { create(:stylist) }
    let(:client) { create(:client) }

    it "should return true if there was a non-cancelled appointment" do
      create(:appointment,
             client: client,
             stylist: stylist,
             cancelled: false,
             start_time: 2.days.ago)
      expect(client.has_seen_stylist?(stylist)).to eq true
    end

    it "should return false if the appointment was cancelled" do
      create(:appointment,
             client: client,
             stylist: stylist,
             cancelled: true,
             start_time: 2.days.ago)
      expect(client.has_seen_stylist?(stylist)).to eq false
    end

    it "should return false if no appointments are found" do
      expect(client.has_seen_stylist?(stylist)).to eq false
    end

    it "should return false if appointment hasn't happened yet" do
      create(:appointment,
             client: client,
             stylist: stylist,
             cancelled: true,
             start_time: 2.days.from_now)
      expect(client.has_seen_stylist?(stylist)).to eq false
    end
  end

  describe "#has_address_on_file?" do
    it "returns true if user has an address" do
      client = create(:client)
      create(:address, user: client)
      expect(client.has_address_on_file?).to eq true
    end

    it "returns false if user doesn't have an address" do
      client = create(:client)
      expect(client.has_address_on_file?).to eq false
    end
  end

  # For SettingsHelpers concern that gets mixed in to User
  context "User Settings" do
    describe "#enable_booking!" do
      it "enables the booking for a stylist" do
        stylist = create(:stylist)
        stylist.settings.update(enable_booking: false)
        expect(stylist.enable_booking).to eq false
        stylist.enable_booking!
        expect(stylist.enable_booking).to eq true
      end
    end

    describe "#make_premium!" do
      it "turns an account for stylist to premium" do
        stylist = create(:stylist)
        expect(stylist.premium_membership).to eq false
        stylist.make_premium!
        expect(stylist.premium_membership).to eq true
      end
    end

    describe "#verify!" do
      it "verifies the stylist" do
        stylist = create(:stylist)
        expect(stylist.verified).to eq false
        stylist.verify!
        expect(stylist.verified).to eq true
      end
    end

    describe "#enable_email!" do
      it "turns on email notifications for user" do
        stylist = create(:stylist)
        expect(stylist.booking_emails).to eq false
        stylist.enable_email!
        expect(stylist.booking_emails).to eq true
      end
    end

    describe "#enable_texting!" do
      it "turns on email notifications for user" do
        stylist = create(:stylist)
        expect(stylist.booking_texts).to eq false
        stylist.enable_texting!
        expect(stylist.booking_texts).to eq true
      end
    end

    describe "#premium_member?" do
      it "returns true if user has setting set to true" do
        client = create(:client)
        client.make_premium!
        expect(client.premium_member?).to eq true
      end

      it "defautls to false if setting isn't set yet" do
        client = create(:client)
        expect(client.premium_member?).to eq false
      end
    end

    describe "#verified_by_membership?" do
      it "returns true if user has setting set to true" do
        client = create(:client)
        client.verify!
        expect(client.verified_by_management?).to eq true
      end

      it "defaults to false if setting isn't set yet" do
        client = create(:client)
        expect(client.verified_by_management?).to eq false
      end
    end

    describe "#send_booking_email?" do
      let(:stylist) { create(:stylist) }

      it "returns false by default" do
        expect(stylist.send_booking_email?).to eq false
      end

      it "returns true if enabled" do
        stylist.enable_email!
        expect(stylist.send_booking_email?).to eq true
      end
    end
  end
end
