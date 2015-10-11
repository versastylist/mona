class AppointmentBooker
  attr_reader :order, :client, :start_time, :end_time, :stylist
  def initialize(options = {})
    @order = options[:order]
    @client = options[:client]
    @start_time = options[:start]
    @end_time = options[:end]
    @stylist = options[:stylist]
  end

  def book
    appointment = Appointment.new(
      start_time: start_time,
      end_time: end_time,
      stylist: stylist,
      client: client,
      order: order
    )
    appointment.save
  end
end
