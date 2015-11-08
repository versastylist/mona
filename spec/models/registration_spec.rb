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
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avatar       :string
#  avatar_cache :string
#  bio          :text
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
    it { should_not have_valid(:first_name).when('$pencer', 's') }
    it { should have_valid(:first_name).when('spencer-charles') }
    it { should have_valid(:gender).when('Male', 'Female') }
    it { should_not have_valid(:last_name).when('@ixon') }
    it { should_not have_valid(:phone_number).when('slkjs', '234', '234234234234') }
  end
end
