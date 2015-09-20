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
#  facebook     :string
#  linked_in    :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  avatar       :string
#  avatar_cache :string
#

class Registration < ActiveRecord::Base
  GENDERS = ['Male', 'Female']
  belongs_to :user

  validates_presence_of :dob,
    :gender, :first_name,
    :last_name, :phone_number, :user
  validates :first_name,
    format: { with: /\A[a-zA-Z-]*\z/ }
  validates :gender,
    inclusion: { in: GENDERS }
  validate :facebook_link?
  validate :linked_in_link?

  mount_uploader :avatar, AvatarUploader

  private

  def facebook_link?
    if facebook.present?
      unless facebook.match(/facebook/) && facebook.match(/(http|https)/)
        errors[:facebook] << "must be a valid Facebook URL"
      end
    end
  end

  def linked_in_link?
    if linked_in.present?
      unless linked_in.match(/linkedin/) && linked_in.match(/(http|https)/)
        errors[:linked_in] << "must be a valid LinkedIn URL"
      end
    end
  end
end
