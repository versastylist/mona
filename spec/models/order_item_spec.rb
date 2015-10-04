# == Schema Information
#
# Table name: order_items
#
#  id                 :integer          not null, primary key
#  service_product_id :integer
#  order_id           :integer
#  unit_price         :decimal(12, 3)
#  quantity           :integer
#  total_price        :decimal(12, 3)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_service_product_id  (service_product_id)
#

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:service_product) }
  end
end
