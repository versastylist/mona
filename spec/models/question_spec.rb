# == Schema Information
#
# Table name: questions
#
#  id               :integer          not null, primary key
#  client_question  :string           not null
#  stylist_question :string           not null
#  questionnaire_id :integer          not null
#

RSpec.describe Question, type: :model do
  context "associations" do
    it { should belong_to(:questionnaire) }
    # need to add assocation with stylist later
    it { should have_many(:answers) }
  end

  context "validations" do
    it { should validate_presence_of(:client_question)}
    it { should validate_presence_of(:stylist_question)}
    it { should validate_inclusion_of(:additional_info)
      .in_array([true, false])}
  end
end
