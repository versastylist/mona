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

class StylistReview < ActiveRecord::Base
  belongs_to :client,
    class_name: 'User',
    foreign_key: 'client_id'
  belongs_to :stylist,
    class_name: 'User',
    foreign_key: 'stylist_id'

  validates :body,
    presence: true
end
