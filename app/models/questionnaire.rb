# == Schema Information
#
# Table name: questionnaires
#
#  id                 :integer          not null, primary key
#  questionnaire_type :integer          not null
#

class Questionnaire < ActiveRecord::Base
  has_many :questions

  def fetch_or_initialize(id)
    result = id ? Questionnaire.find(id) : nil
    unless result
      # send admin e-mail to create/fix questionnaire
    end
    return result
  end

  def completed?(user)
    # find each question_id from answers
    q_ids = user.answers.map { |a| a.question_id }
    # see if each question has an answer
    questions.each { |q| return false unless q_ids.include?(q.id) }

    return true
  end
end
