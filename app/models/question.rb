# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  client_question  :string
#  stylist_question :string
#  additional_info  :boolean
#  questionnaire_id :integer
#

class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :answers

  validates :client_question,
    presence: true
  validates :stylist_question,
    presence: true
  validates :additional_info,
    inclusion: {in: [true, false]}
  validates :questionnaire,
    presence: true
end
