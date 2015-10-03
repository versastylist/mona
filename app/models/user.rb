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
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  include StylistSearch
  has_one :registration
  has_one :questionnaire
  has_one :payment_info
  has_one :primary_address, -> { where(primary: true) }, class_name: 'Address'
  has_many :addresses
  has_many :services
  has_many :service_products, through: :services
  has_many :service_menus, through: :services
  has_many :schedules, foreign_key: 'stylist_id'

  validates :username,
    presence: true,
    length: { minimum: 2, maximum: 24 },
    uniqueness: true,
    format: { with: /\A[a-zA-Z0-9]+\Z/, message: "cannot contain spaces" }
  validates :agree_to_terms, presence: true
  validates :role, inclusion: %w{user client stylist admin}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  delegate :avatar_url, to: :registration

  scope :clients,  -> { where(role: "client") }
  scope :stylists, -> { where(role: "stylist") }


  def self.from_params(params)
    find_by(id: params) || find_by(username: params)
  end

  def to_param
    stylist? ? username.parameterize : id.to_s
  end

  def client?
    role == "client"
  end

  def stylist?
    role == "stylist"
  end

  def admin?
    role == "admin"
  end

  def verified_by_management?
    # This needs to be changed once we have the concept
    # of verifying a stylist to be able to work
    true
  end

  def completed_registration?
    [registration, payment_info].all?
    # [registration, questionnaire, payment_info].all?
    # final impementation once other models are done
  end

  def authenticated?
    true
  end
end
