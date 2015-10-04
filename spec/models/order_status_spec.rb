# == Schema Information
#
# Table name: order_statuses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  context "associations" do
    it { should have_many(:orders) }
  end

  context "validations" do
    it { should have_valid(:name).when('In Progress', 'Complete') }
    it { should_not have_valid(:name).when('', 'random', nil, 0) }
  end
end
