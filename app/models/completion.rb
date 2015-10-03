# == Schema Information
#
# Table name: completions
#
#  id         :integer          not null, primary key
#  survey_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Completion < ActiveRecord::Base
end
