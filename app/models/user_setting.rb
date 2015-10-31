# == Schema Information
#
# Table name: user_settings
#
#  id                 :integer          not null, primary key
#  enable_booking     :boolean          default(TRUE)
#  multiple_services  :boolean          default(FALSE)
#  premium_membership :boolean          default(FALSE)
#  booking_texts      :boolean          default(FALSE)
#  booking_emails     :boolean          default(FALSE)
#  verified           :boolean          default(FALSE)
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class UserSetting < ActiveRecord::Base
  belongs_to :user
end
