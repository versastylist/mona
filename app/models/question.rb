class Question < ActiveRecord::Base
  belongs_to :questionnaire
  has_one :answer

  validates :body,
    presence: true
end
