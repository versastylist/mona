# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  survey_id        :integer          not null
#  submittable_id   :integer
#  submittable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Question < ActiveRecord::Base
end
