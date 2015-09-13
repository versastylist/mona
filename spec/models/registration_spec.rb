# == Schema Information
#
# Table name: registrations
#
#  id           :integer          not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  avatar_url   :string
#  dob          :string           not null
#  gender       :string           not null
#  timezone     :string           not null
#  facebook     :string
#  linked_in    :string
#  type         :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
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
    it { should validate_presence_of(:timezone) }
    it { should_not have_valid(:first_name).when('$pencer') }
    it { should have_valid(:first_name).when('spencer-charles') }
  end
end
