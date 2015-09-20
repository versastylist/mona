# == Schema Information
#
# Table name: service_products
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  minute_duration          :integer          not null
#  price                    :decimal(8, 2)    not null
#  details                  :text
#  preparation_instructions :text
#  service_category_id      :integer          not null
#  displayed                :boolean          default(TRUE)
#  user_id                  :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ServiceProduct < ActiveRecord::Base
  belongs_to :service_category
  belongs_to :user

  validates :name,
    presence: true
  validates :price,
    presence: true,
    numericality: { greater_than_or_equal_to: 20 }
  validates :minute_duration,
    presence: true,
    numericality: { greater_than: 5 }
end
