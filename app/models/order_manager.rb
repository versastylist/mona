class OrderManager

  # Needs to check all booked orders and issue pre-authorization within 7-day
  # timeframe
  #
  # Needs to charge all cards that have been pre-authorized and the appointment
  # occured
  #
  #

  def pre_authorize
    charge = Stripe::Charge.create(amount: 1000, currency: 'usd', customer: client.payment_info.stripe_customer_token, capture: false)
    order.charge_id = charge.id
    order.save
  end

  def capture
    charge = Stripe::Charge.retrive(order.charge_id)
    charge.capture
  end

=begin
  charge.status == "succeeded" it was a good charge

=end
end
