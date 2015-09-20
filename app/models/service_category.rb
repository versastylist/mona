# == Schema Information
#
# Table name: service_categories
#
#  id               :integer          not null, primary key
#  name             :string
#  licence_required :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ServiceCategory < ActiveRecord::Base
  has_many :service_products
end
