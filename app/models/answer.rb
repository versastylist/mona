# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  user_type   :integer          not null
#  answer      :boolean          not null
#  user_id     :integer          not null
#  question_id :integer          not null
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

  def update_or_initialize(params)
    question = Question.find(params[:question_id])
    user = User.find(params[:user_id])
    answer = Answer.where(question: question, user: user)

    if question && answer.any?
      answer = answer.first
      answer.update_attributes(params)
    else
      answer = Answer.new(params)
    end

    answer
  end

# we may be able to remove this && even the user_type field, let me know what you think
  def user_type_to_s
    case self.user_type
    when 0
      'client'
    when 1
      'stylist'
    end
  end
end
