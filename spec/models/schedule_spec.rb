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
    it { should have_valid(:state).when('current', 'future') }
    it { should_not have_valid(:state).when('', 'w23lkj', nil) }
  end

  describe "#days_until_over" do
    it "returns number of days until schedule is expired" do
      Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
        schedule = create(:schedule, end_date: 5.days.from_now)
        expect(schedule.days_until_over).to eq 5
      end
    end
  end
end
