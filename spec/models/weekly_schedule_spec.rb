# == Schema Information
#
# Table name: weekly_schedules
#
#  id         :integer          not null, primary key
#  stylist_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe WeeklySchedule, type: :model do
  context "associations" do
    it { should belong_to(:stylist) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end
