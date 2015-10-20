class StylistScheduleDisplayer
  attr_reader :stylist, :event_sources
  def initialize(stylist)
    @stylist = stylist
    @event_sources = []
  end

  def find_times
    event_sources << find_appointment_times
  end

  def find_free_time

  end

  def find_appointment_times
    appointments = stylist.stylist_appointments
      .where('start_time > ? AND end_time < ?', schedule.start_date, schedule.end_date)

    appointment_source = { events: [], color: '#d9534f', textColor: 'white' }
    appointments.each do |appt|
      appointment_source[:events] << {
        id: appt.id,
        title: "Appointment with: #{appt.client_username}",
        start: appt.start_time,
        end: appt.end_time
      }
    end
    appointment_source
  end

  private

  def schedule
    @schedule ||= stylist.current_schedule
  end
end
