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

require 'rails_helper'

RSpec.describe Completion, type: :model do
  describe "associations" do
    it { should belong_to(:survey) }
    it { should belong_to(:user) }
    it { should have_many(:answers) }
  end

  describe '#answers_attributes=' do
    it 'builds answers to each of the questions' do
      completion = build_stubbed(:completion)

      completion.answers_attributes = {
        1 => { text: 'one' },
        2 => { text: 'two' },
        3 => { text: 'three' }
      }

      answer_attributes =
        completion.
        answers.
        map { |answer| answer.attributes.slice('completion_id', 'question_id', 'text') }
      expect(answer_attributes).to eq [
        { 'completion_id' => completion.id, 'question_id' => 1, 'text' => 'one' },
        { 'completion_id' => completion.id, 'question_id' => 2, 'text' => 'two' },
        { 'completion_id' => completion.id, 'question_id' => 3, 'text' => 'three' }
      ]
    end
  end
end
