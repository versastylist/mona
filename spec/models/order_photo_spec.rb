# == Schema Information
#
# Table name: order_photos
#
#  id          :integer          not null, primary key
#  image       :string
#  description :string
#  purpose     :string
#  order_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_order_photos_on_order_id  (order_id)
#

require 'rails_helper'

RSpec.describe OrderPhoto, type: :model do
  context "associations" do
    it { should belong_to(:order) }
  end

  context "validations" do
    it { should have_valid(:purpose).when('current hairstyle', 'ideal hairstyle') }
    it { should_not have_valid(:purpose).when('', 'random', nil, 234) }
  end

  context "scopes" do
    describe ".current_look" do
      it "returns photos of what client currently looks like" do
        ideal = create(:ideal_order_photo)
        current = create(:current_order_photo)
        expect(OrderPhoto.current_look).to include current
        expect(OrderPhoto.current_look).to_not include ideal
      end
    end

    describe ".ideal_look" do
      it "returns photos of clients ideal look" do
        ideal = create(:ideal_order_photo)
        current = create(:current_order_photo)
        expect(OrderPhoto.ideal_look).to_not include current
        expect(OrderPhoto.ideal_look).to include ideal
      end
    end
  end
end
