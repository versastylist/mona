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

class WeekDay < ActiveRecord::Base
  belongs_to :schedule
  has_many :time_intervals

  before_save :convert_times_to_correct_date

  accepts_nested_attributes_for :time_intervals,
    reject_if: :all_blank, allow_destroy: true

  scope :active, -> { where(active: true) }

  def in_interval?(appointment_start, appointment_end)
    time_intervals.any? do |interval|
      (appointment_start < interval.end_time) && (appointment_end > interval.start_time)
      # http://stackoverflow.com/questions/325933/determine-whether-two-date-ranges-overlap
      # This will allow the overlapping of start/end times
    end
  end

  private

  def convert_times_to_correct_date
    if start_time && end_time
      self[:start_time] = start_time.change({day: day_of_week.day, month: day_of_week.month})
      self[:end_time] = end_time.change({day: day_of_week.day, month: day_of_week.month})
    end
  end
end
