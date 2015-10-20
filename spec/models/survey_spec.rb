# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Survey, type: :model do
  describe "associations" do
    it { should belong_to(:author) }
    it { should have_many(:questions) }
  end

  describe "#registration_survey?" do
    it "returns true if client registration" do
      survey = build_stubbed(:survey, title: 'Client Registration')
      expect(survey.registration_survey?).to eq true
    end

    it "returns true if stylist registration" do
      survey = build_stubbed(:survey, title: 'Stylist Registration')
      expect(survey.registration_survey?).to eq true
    end

    it "returns false for anything else" do
      survey = build_stubbed(:survey, title: 'Example Survey')
      expect(survey.registration_survey?).to eq false
    end
  end
end
