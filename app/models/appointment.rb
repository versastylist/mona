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

class Appointment < ActiveRecord::Base
  belongs_to :order
  belongs_to :stylist,
    class_name: 'User',
    foreign_key: :stylist_id
  belongs_to :client,
    class_name: 'User',
    foreign_key: :client_id

  scope :in_future, -> { where('start_time > ?', DateTime.now.in_time_zone) }
  scope :in_past, -> { where('start_time < ?', DateTime.now.in_time_zone) }
end
