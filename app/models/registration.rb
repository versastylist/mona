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
  validates :dob,
    format: { with: /\d{4}-\d{2}-\d{2}/ }

  validate :confirm_age!

  mount_uploader :avatar, AvatarUploader

  private

  def confirm_age!
    if dob
      age = dob.split('-').first.to_i
      year = Date.today.year
      if (year - age) < 18
        errors.add(:age, "must be 18 years or older!")
      end
    end
  end
end
