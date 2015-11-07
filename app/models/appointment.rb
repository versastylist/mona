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

class Appointment < ActiveRecord::Base
  has_one :time_interval
  belongs_to :order
  belongs_to :stylist,
    class_name: 'User',
    foreign_key: :stylist_id
  belongs_to :client,
    class_name: 'User',
    foreign_key: :client_id

  delegate :username, to: :client, prefix: true
  delegate :username, to: :stylist, prefix: true
  delegate :total, to: :order, prefix: true
  delegate :product_names, :total_time, to: :order

  scope :not_cancelled, -> { where(cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
  scope :in_future, -> { not_cancelled.where('start_time > ?', DateTime.now.in_time_zone) }
  scope :in_past, -> { not_cancelled.where('start_time < ?', DateTime.now.in_time_zone) }
  scope :today, -> { where('start_time > :beg AND start_time < :end', beg: Date.today.beginning_of_day, end: Date.today.end_of_day) }

  def cancel!
    if update(cancelled: true)
      time_interval.destroy
      send_cancel_notifications
    else
      false
    end
  end

  private

  def send_cancel_notifications
    [client, stylist].each do |user|
      if user.receives_email?
        AppointmentMailer.cancel_appointment(self, user.id).deliver_later
      end
      if user.receives_texts?
        TwilioAdapter.appointment_cancellation(self, user)
      end
    end
  end
end
