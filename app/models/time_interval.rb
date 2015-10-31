# == Schema Information
#
# Table name: time_intervals
#
#  id             :integer          not null, primary key
#  title          :string
#  week_day_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  start_time     :datetime
#  end_time       :datetime
#  appointment_id :integer
#
# Indexes
#
#  index_time_intervals_on_week_day_id  (week_day_id)
#

class TimeInterval < ActiveRecord::Base
  belongs_to :week_day
  belongs_to :appointment

  before_save :convert_times_to_correct_date

  private

  def convert_times_to_correct_date
    self[:start_time] = start_time.change({day: week_day.day_of_week.day, month: week_day.day_of_week.month})
    self[:end_time] = end_time.change({day: week_day.day_of_week.day, month: week_day.day_of_week.month})
  end
end
