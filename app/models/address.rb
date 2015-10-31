# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  primary    :boolean          default(FALSE)
#  user_id    :integer          not null
#  address    :string           not null
#  zip_code   :string           not null
#  state      :string           not null
#  appt_num   :string
#  city       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  latitude   :float
#  longitude  :float
#
# Indexes
#
#  index_addresses_on_latitude_and_longitude  (latitude,longitude)
#

class Address < ActiveRecord::Base
  belongs_to :user

  geocoded_by :full_street_address
  after_validation :geocode

  validates_presence_of :address,
    :zip_code, :city, :state, :primary
  validates :zip_code,
    format: { with: /\A\d{5}(?:[-\s]\d{4})?\z/ }

  def full_street_address
    [address, appt_num, city, state, zip_code].join(', ')
  end

  def location
    [latitude, longitude]
  end
end
