# == Schema Information
#
# Table name: week_days
#
#  id          :integer          not null, primary key
#  schedule_id :integer
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  start_time  :datetime
#  end_time    :datetime
#  day_of_week :datetime
#

require 'rails_helper'

RSpec.describe WeekDay, type: :model do
  describe "associations" do
    it { should belong_to(:schedule) }
    it { should have_many(:time_intervals) }
  end

  describe "#in_interval?" do
    let(:week_day) { create(:week_day, day_of_week: 1.day.from_now) }

    it "returns true if appointment end time are in an interval" do
      create(:time_interval, start_time: "11:00am", end_time: "1:00pm", week_day: week_day)
      start_time = 1.day.from_now.change({hour: 11, min: 30})
      end_time = 1.day.from_now.change({hour: 12, min: 30})
      expect(week_day.in_interval?(start_time, end_time)).to eq true
    end

    it "returns false if appointment end time is not in an any interval" do
      start_time = 1.day.from_now.change({hour: 11, min: 30})
      end_time = 1.day.from_now.change({hour: 12, min: 30})
      expect(week_day.in_interval?(start_time, end_time)).to eq false
    end
  end
end
