# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  subtotal         :decimal(12, 3)
#  tax              :decimal(12, 3)
#  total            :decimal(12, 3)
#  state            :string           default("pending")
#  gratuity         :integer
#  cancelled_at     :datetime
#  authorized_at    :datetime
#  captured_at      :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  stripe_charge_id :string
#  cancelled_by     :integer
#

class Order < ActiveRecord::Base
  STATES = [
    'pending',
    'needs pre-auth',
    'pre-authorized',
    'pre-authorized error',
    'capture error',
    'needs refund',
    'refund error',
    'complete',
    'cancelled'
  ]

  belongs_to :order_status
  has_many :order_items
  has_many :service_products, through: :order_items
  has_many :order_photos
  has_one :appointment
  has_one :client, through: :appointment
  has_one :stylist, through: :appointment

  scope :needs_pre_auth, -> { where(state: 'needs pre-auth') }
  scope :pre_authorized, -> { where(state: 'pre-authorized') }
  scope :appointment_before, -> (date) { joins(:appointment).where('appointments.start_time < ?', date) }
  scope :ready_for_pre_auth, -> { needs_pre_auth.appointment_before(6.days.from_now) }
  scope :ready_for_capture,  -> { pre_authorized.appointment_before(DateTime.now.in_time_zone) }
  scope :ready_for_refund, -> { where(state: 'needs refund') }

  before_save :update_totals, unless: :skip_callbacks

  validates :state, inclusion: { in: STATES }

  def current_look_photos
    order_photos.current_look
  end

  def ideal_look_photo
    order_photos.ideal_look
  end

  def product_names
    service_products.pluck(:name).join(', ')
  end

  def empty?
    order_items.length == 0
  end

  def gratuity_rate
    if client && client.gratuity_rate
      client.gratuity_rate
    else
      0.2
    end
  end

  def gratuity
    self[:gratuity] || subtotal * gratuity_rate
  end

  def total
    self[:total] || subtotal + gratuity
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

  def book!
    update(state: 'needs pre-auth')
  end

  def cancel!(user)
    if user.id == client.id
      if appointment.in_24_hours?
        new_state = self.state
      elsif appointment.more_than_48_hours_away?
        new_state = "cancelled"
      else
        new_state = "needs refund"
      end
    else
      new_state = "cancelled"
    end

    update_attributes(
      cancelled_at: DateTime.now.in_time_zone,
      cancelled_by: user.id,
      state: new_state
    )
  end

  def pre_authorize!
    finalize_order
    charge = Stripe::Charge.create(
      amount: (total * 100).to_i,
      currency: 'usd',
      customer: client.payment_info.stripe_customer_token,
      capture: false
    )
    # TODO: Fix this LoD violation with the customer token.  Is there a better
    # solution besides delegation or no?

    if charge.status == "succeeded"
      update_attributes(
        stripe_charge_id: charge.id,
        state: 'pre-authorized',
        authorized_at: DateTime.now.in_time_zone,
      )
    else
      update(state: 'pre-authorized error')
      InternalMailer.bad_pre_auth_charge(id).deliver_later
    end
  end

  def capture_charge!
    charge = Stripe::Charge.retrieve(stripe_charge_id)
    captured_charge = charge.capture

    if captured_charge.status == "succeeded"
      update_attributes(state: 'complete', captured_at: DateTime.now.in_time_zone )
    else
      update(state: 'capture error')
      InternalMailer.bad_capture_charge(id).deliver_later
    end
  end

  def refund_50_charge!
    charge = Stripe::Charge.create(
      amount: ((subtotal / 2) * 100).to_i,
      currency: 'usd',
      customer: client.payment_info.stripe_customer_token,
    )
    if captured_charge.status == "succeeded"
      update_attributes(
        state: 'complete',
        captured_at: DateTime.now.in_time_zone,
        stripe_charge_id: charge.id
      )
    else
      update(state: 'refund error')
      InternalMailer.bad_refund_collection(id).deliver_later
    end
  end

  def finalize_order
    grat = subtotal * gratuity_rate
    self[:gratuity] = grat
    self[:total] = subtotal + grat
    save!
  end

  private

  def update_totals
    self[:subtotal] = subtotal
  end
end
