class PreAuthorizeOrderJob < ActiveJob::Base
  queue_as :default

  def perform(order_id)
    # Do something later
  end
end
