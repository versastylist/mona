# == Schema Information
#
# Table name: week_days
#
#  id                 :integer          not null, primary key
#  day_of_week        :string           not null
#  start_time         :datetime
#  end_time           :datetime
#  weekly_schedule_id :integer
#  active             :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe WeekDay, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
