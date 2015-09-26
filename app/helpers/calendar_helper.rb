module CalendarHelper
  def days_of_the_week
    ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
  end

  def schedule_week_one
    [
      1.day.from_now, 2.day.from_now, 3.days.from_now,
      4.days.from_now, 5.days.from_now, 6.days.from_now,
      7.days.from_now
    ]
  end

  def schedule_week_two
    [
      8.days.from_now, 9.days.from_now, 10.days.from_now,
      11.days.from_now, 12.days.from_now, 13.days.from_now,
      14.days.from_now
    ]
  end
end
