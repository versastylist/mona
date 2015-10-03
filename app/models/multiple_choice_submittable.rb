# == Schema Information
#
# Table name: multiple_choice_submittables
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MultipleChoiceSubmittable < ActiveRecord::Base
  has_many :options, foreign_key: :question_id
  has_one :question, as: :submittable

  accepts_nested_attributes_for :options, reject_if: :all_blank

  def options_for_form
    if options.any?
      options
    else
      [Option.new, Option.new, Option.new]
    end
  end
end
