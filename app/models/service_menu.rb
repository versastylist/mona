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
  has_many :services
  has_many :service_products, through: :services
end
