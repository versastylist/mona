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

  context "validations" do
    it { should have_valid(:quantity).when(1, 2, 10) }
    it { should_not have_valid(:quantity).when(0, '', nil) }
  end

  describe "#unit_price" do
    it "returns products price if not set" do
      product = create(:service_product, price: 50)
      order_item = create(:order_item, service_product: product)
      expect(order_item.unit_price).to eq 50
    end
  end

  describe "#total_price" do
    it "returns unit price multiplied by quantity" do
      product = create(:service_product, price: 50)
      order_item = create(:order_item, service_product: product, quantity: 2)
      expect(order_item.total_price).to eq 100
    end
  end

  describe "#total_minutes" do
    it "returns quantity times service products length", callbacks: true do
      product = create(:service_product, hours: 1, minutes: 30)
      order_item = create(:order_item, service_product: product, quantity: 2)
      expect(order_item.total_minutes).to eq 180
    end
  end
end
