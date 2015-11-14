class RefundCollectionJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    @order.refund_50_charge! if @order
  end
end
