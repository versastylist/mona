# == Schema Information
#
# Table name: time_intervals
#
#  id          :integer          not null, primary key
#  title       :string
#  start_time  :time             not null
#  end_time    :time             not null
#  week_day_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_time_intervals_on_week_day_id  (week_day_id)
#
# Foreign Keys
#
#  fk_rails_0440bfa3c9  (week_day_id => week_days.id)
#

class TimeInterval < ActiveRecord::Base
  belongs_to :week_day
end
