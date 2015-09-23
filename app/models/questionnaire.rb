# == Schema Information
#
# Table name: questionnaires
#
#  id :integer          not null, primary key
#

class Questionnaire < ActiveRecord::Base
  has_many :questions

  def fetch_or_initialize(id)
    result = id ? Questionnaire.find(id) : nil
    unless result
      # send admin e-mail to create/fix questionnaire
    end
    result
  end

  def completed?(user)
    answers = user.answers
    questions && user && answers && questions.count == user.answers.count
  end
end
