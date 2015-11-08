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
    appointment.save!

    send_appointment_confirmations(appointment)

    week_day.time_intervals.create!(
      start_time: start_time,
      end_time: interval_end_time,
      title: "Appointment Booking with client: #{client.id}",
      appointment_id: appointment.id,
    )
    order.complete!
  end

  # First time booking add 15 minutes
  def interval_end_time
    if client.has_seen_stylist?(stylist)
      DateTime.parse(end_time)
    else
      DateTime.parse(end_time) + 15.minutes
    end
  end

  def send_appointment_confirmations(appointment)
    [client, stylist].each do |user|
      if user.receives_texts?
        TwilioAdapter.appointment_confirmation(appointment, user)
      end

      if user.receives_email?
        AppointmentMailer.appointment_confirmation(appointment, user.id).deliver_later
      end
    end
  end
end
