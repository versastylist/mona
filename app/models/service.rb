# == Schema Information
#
# Table name: services
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  service_menu_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Service < ActiveRecord::Base
  has_many :service_products
  belongs_to :stylist, class_name: 'User', foreign_key: 'user_id'
  belongs_to :service_menu
  accepts_nested_attributes_for :service_products, reject_if: :all_blank, allow_destroy: true

  validates :service_menu_id,
    presence: true
  validates :user_id,
    presence: true
end
