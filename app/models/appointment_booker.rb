class AppointmentBooker
  attr_reader :order, :client, :start_time, :end_time, :stylist, :week_day
  def initialize(options = {})
    @order = options[:order]
    @client = options[:client]
    @start_time = options[:start]
    @end_time = options[:end]
    @stylist = options[:stylist]
    @week_day = options[:week_day]
  end

  def book
    appointment = Appointment.new(
      start_time: start_time,
      end_time: end_time,
      stylist: stylist,
      client: client,
      order: order
    )
    week_day.time_intervals.create!(
      start_time: start_time,
      end_time: end_time,
      title: "Appointment Booking with client: #{client.id}"
    )
    order.complete!
    appointment.save!
  end
end
