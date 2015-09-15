# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  value           :boolean
#  additional_info :string
#  question_id     :integer
#

RSpec.describe Answer, type: :model do
  context "associations" do
    it { should belong_to(:question) }
  end

  context "validations" do
    it { should validate_presence_of(:value) }
  end
end
