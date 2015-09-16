# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  body             :string
#  questionnaire_id :integer
#

class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_one :answer

  validates :body,
    presence: true
  validates :questionnaire_id,
    presence: true
end
