# == Schema Information
#
# Table name: completions
#
#  id         :integer          not null, primary key
#  survey_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Completion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :user
  has_many :answers

  def answers_attributes=(answers_attributes)
    answers_attributes.each do |question_id, answer_attributes|
      answers.build(answer_attributes.merge(question_id: question_id))
    end
  end

  def update_completion(answer_attrs)
    answer_attrs.each do |key, attrs|
      answer = Answer.find(attrs[:id])
      answer.update(text: attrs[:text])
    end
  end

  def has_pets?
    question = survey.questions.find_by(title: 'Do you have pets?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def has_carpet?
    question = survey.questions.find_by(title: 'Is your place carpeted?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def allow_kids?
    question = survey.questions.find_by(title: 'Would you use this service for your children?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def is_smoker?
    question = survey.questions.find_by(title: 'Are you a smoker?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def has_skin_condition?
    question = survey.questions.find_by(title: 'Do you have any current skin conditions?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def has_medical_condition?
    question = survey.questions.find_by(title: 'Do you have any current medical conditions?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def serve_pets?
    question = survey.questions.find_by(title: 'Would you service a client who owns a pet?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def serve_kids?
    question = survey.questions.find_by(title: 'Would you service children?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def carpet_allergy?
    question = survey.questions.find_by(title: 'Are you allergic to carpeted areas?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def serve_smoker?
    question = survey.questions.find_by(title: "Would you service a client who's an indoor smoker?")
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def serve_medical_condition?
    question = survey.questions.find_by(title: 'Would you service a client who has a medical condition?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end

  def serve_skin_condition?
    question = survey.questions.find_by(title: 'Would you service a client who has a skin condition?')
    answers.find_by(question_id: question.id).try(:text) == "1"
  end
end
