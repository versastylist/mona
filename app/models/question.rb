# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  client_question  :string           not null
#  stylist_question :string           not null
#  questionnaire_id :integer          not null
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
