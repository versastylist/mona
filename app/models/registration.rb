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
  PHONE_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/

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
