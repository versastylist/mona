class CaptureOrderJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    @order.capture_charge! if @order
  end
end
