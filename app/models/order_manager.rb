class OrderManager

  # Needs to check all booked orders and issue pre-authorization within 7-day
  # timeframe
  #
  # Needs to charge all cards that have been pre-authorized and the appointment
  # occured

  def pre_authorize_orders
    Order.ready_for_pre_auth.each do |order|
      PreAuthorizeOrderJob.perform_later(order.id)
    end
  end

  def capture_orders
    Order.ready_for_capture.each do |order|
      CaptureOrderJob.perform_later(order.id)
    end
  end
end
