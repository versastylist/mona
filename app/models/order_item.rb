# == Schema Information
#
# Table name: order_items
#
#  id                 :integer          not null, primary key
#  service_product_id :integer
#  order_id           :integer
#  unit_price         :decimal(12, 3)
#  quantity           :integer
#  total_price        :decimal(12, 3)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_order_items_on_order_id            (order_id)
#  index_order_items_on_service_product_id  (service_product_id)
#
# Foreign Keys
#
#  fk_rails_31e5b13010  (service_product_id => service_products.id)
#  fk_rails_e3cb28f071  (order_id => orders.id)
#

class OrderItem < ActiveRecord::Base
  belongs_to :service_product
  belongs_to :order

  validates :quantity,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  before_save :finalize

  delegate :name, :minute_duration, to: :service_product

  def unit_price
    if persisted?
      self[:unit_price]
    else
      service_product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  def total_minutes
    quantity * minute_duration
  end

  private

  def product_present
    if service_product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
