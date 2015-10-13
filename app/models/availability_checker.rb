class AvailabilityChecker
  attr_reader :stylist, :appointment_length, :available_times
  def initialize(stylist, appointment_length)
    @stylist = stylist
    @appointment_length = appointment_length
    @available_times = []
  end

  def find_times
    schedule.week_days.each do |week_day|
      start_times = find_acceptable_start_times([], week_day, week_day.start_time, appointment_length)

      start_times.each_with_index do |s_time, index|
        available_times << {
          id: "#{week_day.id}_#{index}",
          title: "Available Appointment",
          start: s_time,
          end: s_time + appointment_length.minutes
        }
      end
    end
    available_times
  end

  def find_acceptable_start_times(array, week_day, start_time, appointment_length)
    end_time = start_time + appointment_length.minutes

    if start_time >= week_day.end_time
      return array
    elsif week_day.in_interval?(end_time)
      find_acceptable_start_times(
        array,
        week_day,
        end_time,
        appointment_length
      )
    else
      array << start_time
      find_acceptable_start_times(
        array,
        week_day,
        end_time,
        appointment_length
      )
    end
  end

  def buffer_time
    GlobalSetting.instance.appointment_buffer
  end

  private

  def schedule
    @schedule ||= stylist.current_schedule
  end

  def order_minutes
    @min ||= order_time * 60
  end
end
