# == Schema Information
#
# Table name: service_menus
#
#  id               :integer          not null, primary key
#  name             :string
#  licence_required :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ServiceMenu < ActiveRecord::Base
  MENU_NAMES = [
    "Hair Cut","Weave",
    "Blowout And Sets", "Natural",
    "Barber", "Nails",
    "Makeup", "Specialties"
  ]

  has_many :services
  has_many :service_products, through: :services

  validates :name, inclusion: { in: MENU_NAMES }
end
