class AppointmentBooker
  def initialize(options = {})
    @order = options[:order]
    @client = options[:client]
    @start_time = options[:start]
    @end_time = options[:end]
  end

  def book

  end
end
