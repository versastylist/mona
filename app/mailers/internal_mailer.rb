class InternalMailer < ApplicationMailer
  def bad_pre_auth_charge(order_id)
    @order = Order.find(order_id)

    mail(
      to: User.admins.pluck(:email).join(', '),
      subject: 'Pre Authorization Failure'
    )
  end

  def bad_capture_charge(order_id)
    @order = Order.find(order_id)

    mail(
      to: User.admins.pluck(:email).join(', '),
      subject: 'Capture Payment Failure'
    )
  end
end
