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
  has_one :time_interval, dependent: :destroy
  belongs_to :order
  belongs_to :stylist,
    class_name: 'User',
    foreign_key: :stylist_id
  belongs_to :client,
    class_name: 'User',
    foreign_key: :client_id

  delegate :username, to: :client, prefix: true
  delegate :username, to: :stylist, prefix: true
  delegate :total, :subtotal, to: :order, prefix: true
  delegate :product_names, :total_time, to: :order
  delegate :order_photos, to: :order

  scope :not_cancelled, -> { where(cancelled: false) }
  scope :cancelled, -> { where(cancelled: true) }
  scope :in_future, -> { not_cancelled.where('start_time > ?', DateTime.now.in_time_zone) }
  scope :in_past, -> { not_cancelled.where('start_time < ?', DateTime.now.in_time_zone) }
  scope :today, -> { where('start_time > :beg AND start_time < :end', beg: Date.today.beginning_of_day, end: Date.today.end_of_day) }

  def cancel!(user)
    if update(cancelled: true)
      order.cancel!(user)
      time_interval.destroy
      send_cancel_notifications
    else
      false
    end
  end

  def client_location
    client.full_street_address
  end

  def stylist_location
    stylist.full_street_address
  end

  def in_24_hours?
    return false if start_time < DateTime.now.in_time_zone
    hours_away <= 24
  end

  def more_than_48_hours_away?
    return false if start_time < DateTime.now.in_time_zone
    hours_away >= 48
  end

  def hours_away
    (start_time - DateTime.now.in_time_zone).to_i / 3600
  end

  private

  def send_cancel_notifications
    [client, stylist].each do |user|
      if user.receives_email?
        AppointmentMailer.cancel_appointment(self.id, user.id).deliver_now
      end
      if user.receives_texts?
        TwilioAdapter.appointment_cancellation(self, user)
      end
    end
  end
end
