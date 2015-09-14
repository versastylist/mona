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
#  registration_id        :integer
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
end
