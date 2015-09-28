# == Schema Information
#
# Table name: service_menus
#
#  id               :integer          not null, primary key
#  name             :string
#  licence_required :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ServiceMenu, type: :model do
  context "associations" do
    it { should have_many(:services) }
    it { should have_many(:service_products).through(:services) }
  end
end
