# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  completion_id :integer          not null
#  question_id   :integer          not null
#  text          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :completion
  belongs_to :question
end
