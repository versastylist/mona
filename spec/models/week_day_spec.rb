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
    it "returns true if start/end time are in an interval" do

    end

    it "returns false if start/end time are not in an any interval" do

    end
  end
end
