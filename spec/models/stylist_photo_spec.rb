# == Schema Information
#
# Table name: stylist_photos
#
#  id          :integer          not null, primary key
#  stylist_id  :integer
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#

require 'rails_helper'

RSpec.describe StylistPhoto, type: :model do
  describe "associations" do
    it { should belong_to(:stylist) }
  end
end
