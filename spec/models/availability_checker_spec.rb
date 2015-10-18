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
      times = checker.find_times

      expect(times.first[:start]).to  eq(1.day.from_now.change({hour: 9, min: 0}))
      expect(times.first[:end]).to    eq(1.day.from_now.change({hour: 10, min: 0}))
      expect(times.second[:start]).to eq(1.day.from_now.change({hour: 10, min: 30}))
      expect(times.second[:end]).to   eq(1.day.from_now.change({hour: 11, min: 30}))
    end

    it "should not return times that conflict with an interval" do
      create(:time_interval,
             start_time: "10:30am",
             end_time: "11:30am",
             week_day: one_day_from_now)

      times = checker.find_times
      expect(times.first[:start]).to eq(1.day.from_now.change({hour: 9, min: 0}))
      expect(times.first[:end]).to   eq(1.day.from_now.change({hour: 10, min: 0}))
    end

    it "should return times that span accross multiple days" do
      create(:week_day,
             schedule: schedule,
             day_of_week: 2.days.from_now,
             start_time: "1:00pm",
             end_time: "3:00pm")

      times = checker.find_times
      expect(times.first[:start]).to eq(1.day.from_now.change({hour: 9, min: 0}))
      expect(times.first[:end]).to   eq(1.day.from_now.change({hour: 10, min: 0}))

      expect(times.second[:start]).to eq(1.day.from_now.change({hour: 10, min: 30}))
      expect(times.second[:end]).to   eq(1.day.from_now.change({hour: 11, min: 30}))

      expect(times.third[:start]).to eq(2.days.from_now.change({hour: 13, min: 0}))
      expect(times.third[:end]).to   eq(2.days.from_now.change({hour: 14, min: 0}))

      expect(times.fourth[:start]).to eq(2.days.from_now.change({hour: 14, min: 30}))
      expect(times.fourth[:end]).to   eq(2.days.from_now.change({hour: 15, min: 30}))
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
