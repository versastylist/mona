# == Schema Information
#
# Table name: questionnaires
#
#  id                 :integer          not null, primary key
#  questionnaire_type :integer          not null
#

class Questionnaire < ActiveRecord::Base
  has_many :questions
  has_many :questionnaire_completions

  def fetch_or_initialize(id)
    result = id ? Questionnaire.find(id) : nil
    unless result
      # send admin e-mail to create/fix questionnaire
    end
    return result
  end

  def fetch_questionnaire_type(questionnaire_type)
    questionnaire_types = {
      stylist_preferences: 0,
      acknowledgement_statement: 1
    }
    case questionnaire_type
    when 'stylist_preferences'
      return Questionnaire.find_by(
        questionnaire_type: questionnaire_types[:stylist_preferences]
      )
    when 'acknowledgement_statement'
      return Questionnaire.find_by(
        questionnaire_type: questionnaire_types[:acknowledgement_statement]
      )
    end
  end

  def completed?(user)
    # find each question_id from answers
    q_ids = user.answers.map { |a| a.question_id }
    # see if each question has an answer
    questions.each { |q| return false unless q_ids.include?(q.id) }

    questionnaire_completion_params = {
      questionnaire_id: self.id,
      user_id: user.id
    }

    if questionnaire_completions.where(questionnaire_completion_params).empty?
      questionnaire_completions.create(questionnaire_completion_params)
    end

    return true
  end

end
