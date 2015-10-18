# == Schema Information
#
# Table name: appointments
#
#  id         :integer          not null, primary key
#  start_time :datetime         not null
#  end_time   :datetime         not null
#  order_id   :integer
#  stylist_id :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cancelled  :boolean          default(FALSE)
#
# Indexes
#
#  index_appointments_on_client_id   (client_id)
#  index_appointments_on_order_id    (order_id)
#  index_appointments_on_stylist_id  (stylist_id)
#

require 'rails_helper'

RSpec.describe Appointment, type: :model do
  describe "associations" do
    it { should belong_to(:order) }
    it { should belong_to(:stylist) }
    it { should belong_to(:client) }
  end

  context 'scopes' do
    describe '.in_future' do
      it 'returns upcoming appointments' do
        future = create(:appointment, start_time: 2.days.from_now)
        past   = create(:appointment, start_time: 2.days.ago)
        expect(Appointment.in_future).to include future
        expect(Appointment.in_future).to_not include past
      end
    end

    describe '.in_past' do
      it 'returns past appointments' do
        future = create(:appointment, start_time: 2.days.from_now)
        past   = create(:appointment, start_time: 2.days.ago)
        expect(Appointment.in_past).to include past
        expect(Appointment.in_past).to_not include future
      end
    end

    describe '.not_cancelled' do
      it 'returns not cancelled appointments' do
        create(:appointment, cancelled: true)
        create_list(:appointment, 5)
        expect(Appointment.not_cancelled.count).to eq 5
      end
    end

    describe '.cancelled' do
      it 'returns cancelled appointments' do
        cancelled = create(:appointment, cancelled: true)
        expect(Appointment.cancelled).to include cancelled
      end
    end
  end

  describe "#cancel!" do
    it "updates the cancelled attribute" do
      appointment = create(:appointment, :with_interval)
      expect(appointment.cancelled).to eq false
      appointment.cancel!
      expect(appointment.cancelled).to eq true
    end

    it "destroys all time intervals associated with appointment" do
      appointment = create(:appointment, :with_interval)
      expect(appointment.time_interval).to_not be_nil
      appointment.cancel!
      expect(appointment.reload.time_interval).to be_nil
    end

    it "sends mailers to stylist and client" do
      appointment = create(:appointment, :with_interval)
      ActionMailer::Base.deliveries = []
      appointment.cancel!
      expect(ActionMailer::Base.deliveries.count).to eq 2
    end
  end
end
