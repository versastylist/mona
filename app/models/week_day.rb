# == Schema Information
#
# Table name: week_days
#
#  id          :integer          not null, primary key
#  day_of_week :date             not null
#  start_time  :time
#  end_time    :time
#  schedule_id :integer
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class WeekDay < ActiveRecord::Base
  belongs_to :weekly_schedule
end
