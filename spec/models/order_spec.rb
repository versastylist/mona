# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  subtotal        :decimal(12, 3)
#  tax             :decimal(12, 3)
#  total           :decimal(12, 3)
#  order_status_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_orders_on_order_status_id  (order_status_id)
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  context "associations" do
    it { should belong_to(:order_status) }
    it { should have_many(:order_items) }
    it { should have_many(:service_products).through(:order_items) }
  end
end
