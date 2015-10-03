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
end
