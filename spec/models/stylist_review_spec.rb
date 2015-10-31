# == Schema Information
#
# Table name: stylist_reviews
#
#  id         :integer          not null, primary key
#  rating     :integer
#  body       :text
#  client_id  :integer
#  stylist_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stylist_reviews_on_client_id   (client_id)
#  index_stylist_reviews_on_stylist_id  (stylist_id)
#

require 'rails_helper'

RSpec.describe StylistReview, type: :model do
  describe "associations" do
    it { should belong_to(:stylist) }
    it { should belong_to(:client) }
  end

  describe "validations" do
    it { should have_valid(:body).when('great stylist!') }
    it { should_not have_valid(:body).when('', nil) }
  end
end
