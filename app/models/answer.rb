# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  value           :boolean
#  additional_info :string
#  question_id     :integer
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :questionnaire

  validates :value,
    presence: true
end
