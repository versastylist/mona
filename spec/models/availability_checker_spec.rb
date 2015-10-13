require 'rails_helper'

describe AvailabilityChecker do
  let(:order_time) { 60 }
  let(:stylist) { create(:stylist, :with_registration) }
  let(:schedule) do
    create(:schedule,
           stylist: stylist,
           state: "Current")
  end

  describe "#find_times" do
    let(:checker) { described_class.new(stylist, order_time) }
    let!(:one_day_from_now) {
      create(:week_day,
             schedule: schedule,
             day_of_week: 1.day.from_now,
             start_time: "9:00am",
             end_time: "11:00am")
    }

    it "should return array of available times" do
      expect(checker.find_times).to include(
      { id: "1_0",
        start: 1.day.from_now.change({hour: 9, min: 0}),
        end: 1.day.from_now.change({hour: 10, min: 0}),
        title: "Available Appointment"
      })
      expect(checker.find_times).to include(
      { id: "1_1",
        start: 1.day.from_now.change({hour: 10, min: 0}),
        end: 1.day.from_now.change({hour: 11, min: 0}),
        title: "Available Appointment"
      })
    end

    it "should not return times that conflict with an interval" do
      create(:time_interval,
             start_time: "10:30am",
             end_time: "11:30am",
             week_day: one_day_from_now)
      expect(checker.find_times).to include(
      { id: "2_0",
        start: 1.day.from_now.change({hour: 9, min: 0}),
        end: 1.day.from_now.change({hour: 10, min: 0}),
        title: "Available Appointment"
      })
    end

    it "should return times that span accross multiple days" do
      create(:week_day,
             schedule: schedule,
             day_of_week: 2.days.from_now,
             start_time: "1:00pm",
             end_time: "3:00pm")

      times = checker.find_times
      expect(times).to eq [
        {
          id: "3_0",
          start: 1.day.from_now.change({hour: 9, min: 0}),
          end: 1.day.from_now.change({hour: 10, min: 0}),
          title: "Available Appointment"
        },
        {
          id: "3_1",
          start: 1.day.from_now.change({hour: 10, min: 0}),
          end: 1.day.from_now.change({hour: 11, min: 0}),
          title: "Available Appointment"
        },
        {
          id: "4_0",
          start: 2.days.from_now.change({hour: 13, min: 0}),
          end: 2.days.from_now.change({hour: 14, min: 0}),
          title: "Available Appointment"
        },
        {
          id: "4_1",
          start: 2.days.from_now.change({hour: 14, min: 0}),
          end: 2.days.from_now.change({hour: 15, min: 0}),
          title: "Available Appointment"
        }
      ]
    end
  end

  describe "#buffer_time" do
    it "should use the apps singleton setting for buffer time" do
      GlobalSetting.instance.update(appointment_buffer: 30)
      checker = described_class.new(stylist, order_time)
      expect(checker.buffer_time).to eq 30
    end
  end
end
