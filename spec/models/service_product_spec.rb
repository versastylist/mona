# == Schema Information
#
# Table name: service_products
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  minute_duration          :integer          not null
#  hours                    :integer
#  minutes                  :integer
#  price                    :decimal(8, 2)    not null
#  details                  :text
#  preparation_instructions :text
#  displayed                :boolean          default(TRUE)
#  service_id               :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'rails_helper'

RSpec.describe ServiceProduct, type: :model do
  context "associations" do
    it { should belong_to(:service) }
    it { should have_one(:service_menu).through(:service) }
  end

  context "validations" do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:minute_duration) }
    it { should validate_numericality_of(:minute_duration) }
    it { should have_valid(:price).when(20, 30, 50) }
    it { should_not have_valid(:price).when(19, 0, 'apple') }
    it { should have_valid(:minute_duration).when(30, 50, 120) }
    it { should_not have_valid(:minute_duration).when(10, 20, '', nil, 0) }
  end
end
