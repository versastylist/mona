# == Schema Information
#
# Table name: weekly_schedules
#
#  id         :integer          not null, primary key
#  stylist_id :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WeeklySchedule < ActiveRecord::Base
  belongs_to :stylist, class_name: 'User'
  has_many :week_days

  accepts_nested_attributes_for :week_days

  validates :name,
    presence: true
end
