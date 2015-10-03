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
  belongs_to :survey
  belongs_to :user
  has_many :answers

  def answers_attributes=(answers_attributes)
    answers_attributes.each do |question_id, answer_attributes|
      answers.build(answer_attributes.merge(question_id: question_id))
    end
  end
end
