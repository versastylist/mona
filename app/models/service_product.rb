# == Schema Information
#
# Table name: service_products
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  hours                    :integer
#  minutes                  :integer
#  price                    :decimal(8, 2)    not null
#  details                  :text
#  preparation_instructions :text
#  service_category_id      :integer          not null
#  displayed                :boolean          default(TRUE)
#  stylist_id               :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ServiceProduct < ActiveRecord::Base
end
