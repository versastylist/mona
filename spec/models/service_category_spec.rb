# == Schema Information
#
# Table name: service_categories
#
#  id               :integer          not null, primary key
#  name             :string
#  licence_required :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ServiceCategory, type: :model do
  context "associations" do
    it { should have_many(:service_products) }
  end
end
