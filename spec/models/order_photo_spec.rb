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
end
