# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  subtotal         :decimal(12, 3)
#  tax              :decimal(12, 3)
#  total            :decimal(12, 3)
#  state            :string           default("pending")
#  gratuity         :integer
#  cancelled_at     :datetime
#  authorized_at    :datetime
#  captured_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stripe_charge_id :string
#  cancelled_by     :integer
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

  context "delegations" do
    it { should delegate_method(:gratuity_rate).to(:client) }
  end

  context "scopes" do
    describe ".ready_for_pre_auth" do
      let(:needs_pre) { create(:order, state: 'needs pre-auth') }
      let(:complete) { create(:order, state: 'complete') }

      it "returns orders with state of 'needs pre-auth'" do
        Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
          create(:appointment, start_time: 3.days.from_now, order: needs_pre)
          expect(Order.ready_for_pre_auth).to include needs_pre
          expect(Order.ready_for_pre_auth).to_not include complete
        end
      end

      it "only returns orders whose appointments are in less than 7 days" do
        Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
          far_away_pre = create(:order, state: 'needs pre-auth')

          create(:appointment, start_time: 10.days.from_now, order: far_away_pre)
          create(:appointment, start_time: 5.days.from_now, order: needs_pre)
          expect(Order.ready_for_pre_auth).to include needs_pre
          expect(Order.ready_for_pre_auth).to_not include far_away_pre
        end
      end
    end

    describe ".ready_for_capture" do
      let(:needs_capture) { create(:order, state: 'pre-authorized') }
      let(:complete) { create(:order, state: 'complete') }

      it "returns orders with state of 'pre-authorized'" do
        Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
          create(:appointment, start_time: 1.hour.ago, order: needs_capture)
          expect(Order.ready_for_capture).to include needs_capture
          expect(Order.ready_for_capture).to_not include complete
        end
      end

      it "only returns orders whose appointments are in the past" do
        Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
          in_future = create(:order, state: 'pre-authorized')

          create(:appointment, start_time: 1.hour.ago, order: needs_capture)
          create(:appointment, start_time: 1.hour.from_now, order: in_future)
          expect(Order.ready_for_capture).to include needs_capture
          expect(Order.ready_for_capture).to_not include in_future
        end
      end
    end
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

  describe "#book!" do
    it "resets order status to be complete" do
      order = create(:order)

      expect(order.state).to eq "pending"
      order.book!
      expect(order.state).to eq "needs pre-auth"
    end
  end

  describe "#cancel!" do
    it "properly sets cancelled_at and cancelled_by" do
      order = create(:appointment, start_time: 5.hours.from_now).order
      client = order.client

      order.cancel!(client)
      expect(order.cancelled_by).to eq client.id
      expect(order.cancelled_at).to be_within(3.seconds).of(DateTime.now)
    end

    context "cancelled by client" do
      let(:client) { create(:client) }

      it "makes state 'cancelled' if 48 hours away or more" do
        order = create(:appointment, client: client, start_time: 3.days.from_now).order

        order.cancel!(client)
        expect(order.state).to eq 'cancelled'
      end

      it "makes state 'needs refund' if between 24 hours and 48 hours away" do
        order = create(:appointment, client: client, start_time: 26.hours.from_now).order

        order.cancel!(client)
        expect(order.state).to eq 'needs refund'
      end

      it "keeps same state if less than 24 hours away" do
        order = create(:appointment, client: client, start_time: 5.hours.from_now).order
        prev_state = order.state

        order.cancel!(client)
        expect(order.state).to eq prev_state
      end
    end

    context "cancelled by admin or stylist" do
      it "turns state to 'cancelled' for stylists" do
        appointment = create(:appointment, start_time: 4.days.from_now)
        stylist = appointment.stylist
        order = appointment.order

        order.cancel!(stylist)
        expect(order.state).to eq 'cancelled'
        expect(order.cancelled_by).to eq stylist.id
      end

      it "turns state to 'cancelled' for admins" do
        appointment = create(:appointment, start_time: 4.days.from_now)
        admin = create(:admin)
        order = appointment.order

        order.cancel!(admin)
        expect(order.state).to eq 'cancelled'
        expect(order.cancelled_by).to eq admin.id
      end
    end
  end

  describe "#empty?" do
    it 'returns true if no order items are associated' do
      order = build_stubbed(:order)
      expect(order.empty?).to eq true
    end
  end

  describe "#gratuity_rate" do
    it 'returns client gratuity rate if present' do
      client = double(gratuity_rate: 0.1)
      order = build_stubbed(:order)
      allow(order).to receive(:client).and_return(client)

      expect(order.gratuity_rate).to eq 0.1
    end

    it 'returns default of 20% if no client is associated yet' do
      order = build_stubbed(:order)
      expect(order.gratuity_rate).to eq 0.2
    end
  end
end
