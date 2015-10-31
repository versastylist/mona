# == Schema Information
#
# Table name: registrations
#
#  id           :integer          not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  dob          :string           not null
#  gender       :string           not null
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avatar       :string
#  avatar_cache :string
#

class Registration < ActiveRecord::Base
  GENDERS = ['Female', 'Male']
  belongs_to :user
  PHONE_REGEX = /\A(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?\z/

  validates_presence_of :dob,
    :gender, :first_name,
    :last_name, :phone_number, :user
  validates :first_name,
    format: { with: /\A[a-zA-Z-]*\z/ },
    length: { minimum: 2 }
  validates :last_name,
    format: { with: /\A[a-zA-Z-]*\z/ }
  validates :gender,
    inclusion: { in: GENDERS }
  validates :phone_number,
    format: {
      with: PHONE_REGEX,
      message: "bad format"
    }

  mount_uploader :avatar, AvatarUploader
end
