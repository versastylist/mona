# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  subtotal      :decimal(12, 3)
#  tax           :decimal(12, 3)
#  total         :decimal(12, 3)
#  state         :string           default("pending")
#  gratuity      :integer
#  cancelled_at  :datetime
#  authorized_at :datetime
#  captured_at   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ActiveRecord::Base
  STATUSES = [
    'pending',
    'complete',
    'pre-authorized',
    'cancelled'
  ]

  belongs_to :order_status
  has_many :order_items
  has_many :service_products, through: :order_items
  has_many :order_photos
  has_one :appointment
  has_one :client, through: :appointment
  has_one :stylist, through: :appointment

  before_save :update_totals, unless: :skip_callbacks

  validates :state, inclusion: { in: STATUSES }

  def current_look_photos
    order_photos.current_look
  end

  def ideal_look_photo
    order_photos.ideal_look
  end

  def product_names
    service_products.pluck(:name).join(', ')
  end

  def subtotal
    order_items.collect { |oi| oi.valid? ? oi.total_price : 0 }.sum
  end

  def total_items
    order_items.sum(:quantity)
  end

  def total_time
    order_items.inject(0) { |sum, oi| sum + oi.total_minutes }
  end

  def complete!
    update(state: 'complete')
  end

  private

  def update_totals
    self[:subtotal] = subtotal
    self[:total] = subtotal + gratuity
  end
end
