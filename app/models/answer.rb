# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  user_type   :integer
#  answer      :boolean
#  user_id     :integer
#  question_id :integer
#

class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_type,
    presence: true
  validates :answer,
    inclusion: {in: [true, false]}
  validates :user,
    presence: true
  validates :question,
    presence: true

  def fetch_or_initialize(ids)
    check_answer = Answer.where(
      question_id: ids[:question_id],
      user_id: ids[:user_id]
    )
    answer = check_answer.any? ? check_answer.first : Answer.new
  end

  def user_type_to_s
    case self.user_type
    when 0
      'client'
    when 1
      'stylist'
    end
  end
end
