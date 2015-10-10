module CalendarHelper
  def days_of_the_week
    ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday']
  end

  def schedule_week_one
    (1..7).map { |n| n == 1 ? n.day.from_now : n.days.from_now }
  end

  def schedule_week_two
    (8..14).map { |n| n.days.from_now }
  end
end
