class TwilioAdapter
  def self.appointment_cancellation(appt, user)
    new.appointment_cancellation(appt, user)
  end

  def self.appointment_confirmation(appt, user)
    new.appointment_confirmation(appt, user)
  end

  attr_reader :client
  def initialize
    @client = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_AUTH'])
  end

  def send_text(to, content)
    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to,
      body: content
    )
  end

  def appointment_cancellation(appointment, user)
    content = cancellation_text(appointment, user)
    formatted_number = formatted_phone_num(user.phone_number)
    send_text(formatted_number, content)
  end

  def appointment_confirmation(appointment, user)
    content = confirmation_text(appointment, user)
    formatted_number = formatted_phone_num(user.phone_number)
    send_text(formatted_number, content)
  end

  def formatted_phone_num(number)
    unless number =~ /^\+1/
      number.insert(0, "+1")
    end
    number
  end

  private

  def cancellation_text(appointment, user)
    appt = appointment.decorate

    "Appointment on #{appt.start_time} was cancelled."
  end

  def confirmation_text(appointment, user)
    appt = appointment.decorate
    if user.stylist?
      <<-EOH.strip_heredoc
        New appointment on #{appt.start_time} with
        #{appt.client_name} at #{appt.client_location}.

        Order consists of: #{appt.product_names} for a total of
        $#{appt.order_total}
      EOH
    else
      <<-EOH.strip_heredoc
        Appointment confirmation for #{appt.start_time} with
        #{appt.stylist_name}.

        Order consists of: #{appt.product_names} for a total of
        $#{appt.order_total}
      EOH
    end
  end
end
