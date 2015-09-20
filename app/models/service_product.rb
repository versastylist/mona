# == Schema Information
#
# Table name: service_products
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  minute_duration          :integer          not null
#  hours                    :integer
#  minutes                  :integer
#  price                    :decimal(8, 2)    not null
#  details                  :text
#  preparation_instructions :text
#  displayed                :boolean          default(TRUE)
#  service_id               :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ServiceProduct < ActiveRecord::Base
  belongs_to :service
  has_one :service_menu, through: :service

  validates :name,
    presence: true
  validates :price,
    presence: true,
    numericality: { greater_than_or_equal_to: 20 }
  validates :minute_duration,
    presence: true,
    numericality: { greater_than_or_equal_to: 30 }

  before_validation :set_minute_duration

  private

  def set_minute_duration
    self[:minute_duration] = (hours.hour.to_i + minutes.minute.to_i) / 60
  end
end
