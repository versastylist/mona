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
  end
end
