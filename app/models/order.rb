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
end
