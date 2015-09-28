# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  stylist_id :integer          not null
#  state      :string
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ActiveRecord::Base
  belongs_to :stylist, class_name: 'User'
  has_many :week_days

  accepts_nested_attributes_for :week_days
end
