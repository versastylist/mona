class PreAuthorizeOrderJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    @order = Order.find(order_id)
    @order.pre_authorize! if @order
  end
end