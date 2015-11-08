# == Schema Information
#
# Table name: order_photos
#
#  id          :integer          not null, primary key
#  image       :string
#  description :string
#  purpose     :string
#  order_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_order_photos_on_order_id  (order_id)
#

class OrderPhoto < ActiveRecord::Base
  PURPOSES = [
    'current hairstyle',
    'ideal hairstyle'
  ]
  belongs_to :order

  validates :purpose, inclusion: { in: PURPOSES }

  scope :current_look, -> { where(purpose: 'current hairstyle') }
  scope :ideal_look,   -> { where(purpose: 'ideal hairstyle') }

  mount_uploader :image, StylistPhotoUploader
end
