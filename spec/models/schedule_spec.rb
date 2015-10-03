# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  stylist_id :integer          not null
#  state      :string
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Schedule, type: :model do
  context "associations" do
    it { should belong_to(:stylist) }
    it { should have_many(:week_days) }
    it { should accept_nested_attributes_for(:week_days) }
  end

  context "validations" do
  end
end
