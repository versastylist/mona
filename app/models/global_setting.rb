# == Schema Information
#
# Table name: global_settings
#
#  id                 :integer          not null, primary key
#  appointment_buffer :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class GlobalSetting < ActiveRecord::Base
  acts_as_singleton
end
