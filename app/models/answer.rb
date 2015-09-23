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
end
