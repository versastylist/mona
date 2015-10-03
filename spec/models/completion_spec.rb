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
end
