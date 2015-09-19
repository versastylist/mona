# == Schema Information
#
# Table name: registrations
#
#  id           :integer          not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  dob          :string           not null
#  gender       :string           not null
#  facebook     :string
#  linked_in    :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avatar       :string
#  avatar_cache :string
#

require 'rails_helper'

RSpec.describe Registration, type: :model do
  context "associations" do
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:gender) }
    it { should_not have_valid(:first_name).when('$pencer') }
    it { should have_valid(:first_name).when('spencer-charles') }
    it { should have_valid(:gender).when('Male', 'Female', 'Other') }
    it { should have_valid(:facebook).when('https://www.facebook.com/spencer') }
    it { should_not have_valid(:facebook).when('www.google.com/spencer', 'www.facebook.com') }
    it { should have_valid(:linked_in).when('https://www.linkedin.com/spencer') }
    it { should_not have_valid(:linked_in).when('www.google.com/spencer', 'www.linkedin.com') }
  end
end
