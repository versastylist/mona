# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  survey_id        :integer          not null
#  submittable_id   :integer
#  submittable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :survey
  belongs_to :submittable, polymorphic: true

  accepts_nested_attributes_for :submittable

  validates :title,
    presence: true

  def build_submittable(type, attributes)
    submittable_class = type.sub('Question', 'Submittable').constantize
    self.submittable = submittable_class.new(attributes.merge(question: self))
  end
end
