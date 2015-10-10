# == Schema Information
#
# Table name: time_intervals
#
#  id          :integer          not null, primary key
#  title       :string
#  week_day_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  start_time  :datetime
#  end_time    :datetime
#
# Indexes
#
#  index_time_intervals_on_week_day_id  (week_day_id)
#

class TimeInterval < ActiveRecord::Base
  belongs_to :week_day

  before_save :convert_times_to_correct_date

  private

  def convert_times_to_correct_date
    self[:start_time] = start_time.change({day: week_day.day_of_week.day})
    self[:end_time] = end_time.change({day: week_day.day_of_week.day})
  end
end
