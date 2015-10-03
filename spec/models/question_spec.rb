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

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe "associations" do
    it { should have_many(:answers) }
    it { should belong_to(:survey) }
    it { should belong_to(:submittable) }
    it { should accept_nested_attributes_for(:submittable) }
  end

  describe '#build_submittable' do
    it 'builds a submittable with the given type and attributes' do
      expected_value = 1.day.ago
      question = build(:question)

      question.build_submittable('ConfirmSubmittable', created_at: expected_value)

      expect(question.submittable.created_at).to eq expected_value
      expect(question.submittable).to be_a(ConfirmSubmittable)
    end
  end
end
