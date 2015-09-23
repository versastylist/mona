# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  client_question  :string
#  stylist_question :string
#  questionnaire_id :integer
#

class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy

  validates :client_question,
    presence: true
  validates :stylist_question,
    presence: true
  validates :questionnaire,
    presence: true
end
