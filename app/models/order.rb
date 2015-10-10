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
  # belongs_to :client # figure out how to incorporate this
  before_create :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect { |oi| oi.valid? ? oi.total_price : 0 }.sum
  end

  def total_items
    order_items.pluck(:quantity).sum
  end

  def total_time
    order_items.inject(0) { |sum, oi| sum + oi.total_minutes }
  end

  private

  def set_order_status
    status = OrderStatus.find_or_create_by(name: "In Progress")
    self.order_status_id = status.id
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
