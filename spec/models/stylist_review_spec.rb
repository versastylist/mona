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
  pending "add some examples to (or delete) #{__FILE__}"
end
