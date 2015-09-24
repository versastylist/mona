# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  user_type   :integer          not null
#  answer      :boolean          not null
#  user_id     :integer          not null
#  question_id :integer          not null
#

RSpec.describe Answer, type: :model do
  context "associations" do
    it { should belong_to(:question) }
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:user_type) }
    it { should validate_inclusion_of(:answer)
      .in_array([true, false])}
  end
end
