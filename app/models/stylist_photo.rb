# == Schema Information
#
# Table name: stylist_photos
#
#  id         :integer          not null, primary key
#  stylist_id :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StylistPhoto < ActiveRecord::Base
  belongs_to :stylist,
    class_name: 'User',
    foreign_key: 'stylist_id'

  mount_uploader :image, StylistPhotoUploader

  def description
    "Stylist photo"
  end
end
