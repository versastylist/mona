# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  completion_id :integer          not null
#  question_id   :integer          not null
#  text          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "associations" do
    it { should belong_to(:completion) }
    it { should belong_to(:question) }
  end
end
