# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string           not null
#  agree_to_terms         :boolean          default(FALSE)
#  role                   :string
#  settings               :jsonb            default({}), not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  banned                 :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  include SettingsHelpers

  has_one :registration
  has_one :payment_info
  has_one :settings,
    class_name: 'UserSetting'
  has_one :primary_address, -> { where(primary: true) }, class_name: 'Address'
  has_one :current_schedule,
    -> { where(state: "Current") },
    class_name: "Schedule",
    foreign_key: "stylist_id"
  has_one :future_schedule,
    -> { where(state: "Future") },
    class_name: "Schedule",
    foreign_key: "stylist_id"
  has_many :addresses
  has_many :services
  has_many :service_products, through: :services
  has_many :service_menus, through: :services
  has_many :schedules, foreign_key: 'stylist_id'
  has_many :completions
  has_many :stylist_appointments,
    foreign_key: 'stylist_id',
    class_name: 'Appointment'
  has_many :client_appointments,
    foreign_key: 'client_id',
    class_name: 'Appointment'
  has_many :stylist_reviews,
    foreign_key: 'stylist_id',
    class_name: 'StylistReview'
  has_many :client_reviews,
    foreign_key: 'client_id',
    class_name: 'StylistReview'
  has_many :clients, through: :stylist_appointments
  has_many :stylist_photos, foreign_key: 'stylist_id'

  validates :username,
    presence: true,
    length: { minimum: 2, maximum: 24 },
    uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]+\Z/, message: "cannot contain spaces" }
  validates :agree_to_terms, presence: true
  validates :role, inclusion: %w{user client stylist admin}

  searchkick
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  delegate :avatar_url,
    :first_name,
    :last_name,
    :phone_number,
    :dob,
    to: :registration, allow_nil: true

  delegate :enable_booking, to: :settings

  scope :clients,  -> { where(role: "client") }
  scope :stylists, -> { where(role: "stylist") }
  scope :admins, -> { where(role: "admin") }

  def self.from_params(params)
    find_by(id: params) || find_by(username: params)
  end

  # Doesn't allow me to search by specific distance for each user.
  def self.near(co, distance)
    Address.near(co, distance).includes(:user).map { |a| a.user }
  end

  def self.available_service_ids(co, distance)
    near(co, distance).flat_map { |u| u.services.pluck(:id) }.uniq
  end

  # Soft delete banned users
  def self.find_for_authentication(conditions)
    super(conditions.merge(banned: false))
  end

  def admin?
    role == "admin"
  end

  def authenticated?
    true
  end

  def banned?
    banned
  end

  def completed_registration?
    [registration, payment_info, registration_survey].all?
  end

  def client?
    role == "client"
  end

  def has_address_on_file?
    addresses.any?
  end

  def has_seen_stylist?(stylist)
    client_appointments.in_past.
      where(stylist_id: stylist.id).
      where(cancelled: false).present?
  end

  def stylist?
    role == "stylist"
  end

  def registration_survey
    return true if admin? # should be replaced by NullObject pattern later
    completions.joins(:survey).find_by(surveys: { title: "#{role.capitalize} Registration" })
  end

  def to_param
    stylist? ? username.parameterize : id.to_s
  end

  def projected_revenue
    stylist_appointments.
      in_future.joins(:order).sum('orders.subtotal')
  end

  def search_data
    attributes.merge(
      first_name: first_name,
      last_name: last_name,
    )
  end

  def stylist_reminders
    reminders = []
    reminders << "You still need to create your current schedule" unless current_schedule.present?
    reminders << "You still need to create your future schedule" unless future_schedule.present?
    stylist_appointments.today.each do |appt|
      reminders << "You have an appointment today at: #{appt.start_time.strftime('%l:%M %P')}"
    end
    reminders
  end

  def weekly_rev_forecast
    labels = [Date.today, 1.day.from_now, 2.days.from_now, 3.days.from_now, 4.days.from_now, 5.days.from_now, 6.days.from_now]
    english_labels = labels.map { |l| l.strftime('%A') }

    data = labels.each_with_object([]) do |day_of_week, arr|
      day_total = stylist_appointments.where(
                    start_time: day_of_week.beginning_of_day..day_of_week.end_of_day
                  ).joins(:order).sum('orders.subtotal')
      arr << day_total.to_i
    end

    { data: data, labels: english_labels }
  end

  def can_upload_more_photos?
    stylist_photos.count < 8
  end
end
