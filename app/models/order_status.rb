# == Schema Information
#
# Table name: order_statuses
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderStatus < ActiveRecord::Base
  STATUS_NAMES = [
    'In Progress',
    'Complete'
  ].freeze

  has_many :orders

  validates :name,
    presence: true,
    inclusion: { in: STATUS_NAMES }
end
