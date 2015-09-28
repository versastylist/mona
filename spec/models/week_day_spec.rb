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

require 'rails_helper'

RSpec.describe WeekDay, type: :model do
end
