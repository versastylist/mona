module Features
  def open_schedule_for_stylist(stylist, opts = {})
    stylist = create(:stylist)
    options = default_schedule_opts.merge(opts)
    schedule = create(:schedule,
                      stylist: stylist,
                      state: options[:state])

    schedule_week_one.each do |day|
      create(:week_day,
             schedule: schedule,
             day_of_week: day,
             start_time: options[:start_time],
             end_time: options[:end_time])
    end
    schedule
  end

  private

  def default_schedule_opts
    { start_time: "9:00am",
      end_time: "5:00pm",
      state: "Current" }
  end

  # Copied from application helper
  def schedule_week_one
    (1..7).map { |n| n == 1 ? n.day.from_now : n.days.from_now }
  end

  def schedule_week_two
    (8..14).map { |n| n.days.from_now }
  end
end
