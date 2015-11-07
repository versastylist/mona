class TwilioAdapter
  def self.appointment_cancellation(appt, user)
    new.appointment_cancellation(appt, user)
  end

  attr_reader :client
  def initialize
    @client = Twilio::REST::Client.new
  end

  def send_text(to, content)
    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to,
      body: content
    )
  end

  def appointment_cancellation(appointment, user)
    true # MOCK this out for now until I can get twilio credentials from Ricky

    # message = <<-EOH.strip_heredoc
      # Appointment on #{appointment.start_time.strftime('%b %d, %Y at %l:%M %P')}
      # was cancelled.
    # EOH
    # formatted_number = formatted_phone_num(user.phone_number)
    # send_text(formatted_number, message)
  end

  def formatted_phone_num(number)
    unless number =~ /^\+1/
      number.insert(0, "+1")
    end
    number
  end
end
