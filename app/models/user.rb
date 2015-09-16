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
#  registration_id        :integer
#  registration_process   :string           default("registration questions payment")
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,
    presence: true,
    length: { minimum: 2, maximum: 24 },
    uniqueness: true
  validates :username,
    format: { with: /\A[a-zA-Z0-9]+\Z/, message: "cannot contain spaces" }
  validates :agree_to_terms, presence: true
  validates :role, inclusion: %w{client stylist admin}

  has_one :registration
  has_many :addresses

  scope :clients, -> { where(role: "client") }
  scope :stylists, -> { where(role: "stylists") }

  def self.from_param(param)
    if stylist?
      find_by_username!(param)
    else
      find!(param)
    end
  end

  def to_param
    stylist? ? username.parameterize : id.to_s
  end

  def primary_address
    addresses.find_by(primary: true)
  end

  def client?
    role == "client"
  end

  def stylist?
    role == "stylist"
  end

  def completed_registration?
    registration_process.empty?
  end

  def authenticated?
    true
  end

  def registration_process
    self[:registration_process].split(' ')
  end
end
