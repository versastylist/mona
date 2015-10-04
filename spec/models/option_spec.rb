# == Schema Information
#
# Table name: options
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Option, type: :model do
  describe "associations" do
    it { should belong_to(:question) }
  end
end
