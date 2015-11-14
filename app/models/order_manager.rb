class OrderManager
  def self.pre_authorize_orders
    Order.ready_for_pre_auth.each do |order|
      # PreAuthorizeOrderJob.perform_later(order.id)
      Rails.logger.info "Pre authorizing order: #{order.id}"
      order.pre_authorize!
    end
  end

  def self.capture_orders
    Order.ready_for_capture.each do |order|
      # CaptureOrderJob.perform_later(order.id)
      Rails.logger.info "Capturing charge for order: #{order.id}"
      order.capture_charge!
    end
  end

  def self.collect_refund_orders
    Order.ready_for_refund.each do |order|
      # RefundCollectionJob.perform_later(order.id)
      Rails.logger.info "Charging a refund fee for order: #{order.id}"
      order.refund_50_charge!
    end
  end
end
