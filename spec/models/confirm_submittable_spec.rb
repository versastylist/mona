# == Schema Information
#
# Table name: confirm_submittables
#
#  id         :integer          not null, primary key
#  confirmed  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ConfirmSubmittable, type: :model do
  describe "associations" do
    it { should have_one(:question) }
  end
end
