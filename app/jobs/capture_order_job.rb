class CaptureOrderJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    InternalMailer.bad_pre_auth_charge(Order.last.id)
  end
end
