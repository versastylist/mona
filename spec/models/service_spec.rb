# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  service_menu_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Service, type: :model do
  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:service_menu) }
    it { should have_many(:service_products) }
  end
end
