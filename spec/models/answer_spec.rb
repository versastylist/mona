# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  user_type       :integer
#  answer          :boolean
#  additional_info :string
#  user_id         :integer
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
