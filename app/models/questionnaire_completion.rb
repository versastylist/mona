# == Schema Information
#
# Table name: questionnaire_completions
#
#  id               :integer          not null, primary key
#  questionnaire_id :integer          not null
#  user_id          :string           not null
#  created_at       :datetime
#  updated_at       :datetime
#

class QuestionnaireCompletion < ActiveRecord::Base
  belongs_to :questionnaire
  belongs_to :user

  validates :questionnaire,
    presence: true
  validates :user,
    presence: true
end
