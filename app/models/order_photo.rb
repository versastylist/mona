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
  validate :current_photo_limit
  validate :ideal_photo_limit

  scope :current_look, -> { where(purpose: 'current hairstyle') }
  scope :ideal_look,   -> { where(purpose: 'ideal hairstyle') }

  mount_uploader :image, StylistPhotoUploader

  private

  def current_photo_limit
    if purpose == 'current hairstyle'
      if order && order.order_photos.current_look.count >= 2
        errors.add(:current_look, "already has 2 images uploaded")
      end
    end
  end

  def ideal_photo_limit
    if purpose == 'ideal hairstyle'
      if order && order.order_photos.ideal_look.count != 0
        errors.add(:ideal_photo, "has already been uploaded")
      end
    end
  end
end
