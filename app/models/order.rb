# == Schema Information
#
# Table name: orders
#
#  id              :integer          not null, primary key
#  subtotal        :decimal(12, 3)
#  tax             :decimal(12, 3)
#  total           :decimal(12, 3)
#  order_status_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_orders_on_order_status_id  (order_status_id)
#

class Order < ActiveRecord::Base
  belongs_to :order_status
  has_many :order_items
  has_many :service_products, through: :order_items
  has_many :order_photos
  has_one :appointment

  # TODO: Figure out how to associate order with clients for marketing
  # belongs_to :client

  before_create :set_order_status
  before_save :update_subtotal

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
    status = OrderStatus.find_or_create_by(name: "Complete")
    self.order_status_id = status.id
    save!
  end

  private

  def set_order_status
    status = OrderStatus.find_or_create_by(name: "In Progress")
    self.order_status_id = status.id
  end

  def update_subtotal
    # TODO: determine if I'm going to need subtotal or not and choose what to do
    self[:subtotal] = subtotal
    self[:total] = subtotal
  end
end
