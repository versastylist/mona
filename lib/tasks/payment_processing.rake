namespace :payments do
  task :process => :environment do
    OrderManager.pre_authorize_orders
    OrderManager.capture_orders
    OrderManager.collect_refund_orders
  end
end
