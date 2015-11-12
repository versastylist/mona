# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  subtotal      :decimal(12, 3)
#  tax           :decimal(12, 3)
#  total         :decimal(12, 3)
#  state         :string           default("pending")
#  gratuity      :integer
#  cancelled_at  :datetime
#  authorized_at :datetime
#  captured_at   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  context "associations" do
    it { should have_one(:appointment) }
    it { should have_one(:client).through(:appointment) }
    it { should have_one(:stylist).through(:appointment) }
    it { should have_many(:order_items) }
    it { should have_many(:order_photos) }
    it { should have_many(:service_products).through(:order_items) }
  end

  describe "#product_names" do
    it "returns comma separted list of product names" do
      order = create(:order)
      buzz = create(:service_product, name: "Buzz cut")
      shave = create(:service_product, name: "Shave")
      create(:order_item, service_product: buzz, order: order)
      create(:order_item, service_product: shave, order: order)

      expect(order.product_names).to eq "Buzz cut, Shave"
    end
  end

  describe "#total_items" do
    it "sums the total quantity of all order items" do
      order = create(:order)
      create(:order_item, quantity: 2, order: order)
      create(:order_item, quantity: 1, order: order)
      expect(order.total_items).to eq 3
    end
  end

  describe "#complete!" do
    it "resets order status to be complete" do
      order = create(:order)

      expect(order.state).to eq "pending"
      order.complete!
      expect(order.state).to eq "complete"
    end
  end
end
