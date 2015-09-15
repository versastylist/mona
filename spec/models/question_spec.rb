# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  body             :string
#  questionnaire_id :integer
#

RSpec.describe Question, type: :model do
  context "associations" do
    it { should belong_to(:questionnaire) }
    # need to add assocation with stylist later
    it { should have_one(:answer) }
  end

  context "validations" do
    it { should validate_presence_of(:body) }
  end
end