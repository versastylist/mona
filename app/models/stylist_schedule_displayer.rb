class StylistScheduleDisplayer
  attr_reader :stylist, :event_sources
  def initialize(stylist)
    @stylist = stylist
    @event_sources = []
  end

  def find_times
    event_sources << find_appointment_times
    event_sources << find_free_time
  end

  # Definitely should be refactored.  Not optimal algorithm at all.
  def find_free_time
    appointment_source = { events: [], color: '#449d44', textColor: 'white' }

    schedule.week_days.each do |wday|
      sorted_intervals = wday.time_intervals.order(:start_time)
      start_time = wday.start_time

      if wday.time_intervals.empty?
        appointment_source[:events] << {
          start: start_time,
          end: wday.end_time,
          id: "#{wday.id}",
          title: 'Available For Booking'
        }
      else
        sorted_intervals.each do |interval|
          appointment_source[:events] << {
            start: start_time,
            end: interval.start_time,
            id: "#{wday.id}_#{interval.id}",
            title: 'Available For Booking'
          }
          start_time = interval.end_time

          if sorted_intervals.last == interval
            appointment_source[:events] << {
              start: interval.end_time,
              end: wday.end_time,
              id: "#{wday.id}_#{interval.id}",
              title: 'Available For Booking'
            }
          end
        end
      end
    end
    appointment_source
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
    @schedule ||= stylist.current_schedule || NullSchedule.new
  end

  class NullSchedule
    def start_date
      1.day.ago
    end

    def end_date
      10.days.from_now
    end
  end
end
