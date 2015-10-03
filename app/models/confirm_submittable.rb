# == Schema Information
#
# Table name: confirm_submittables
#
#  id         :integer          not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ConfirmSubmittable < ActiveRecord::Base
end
