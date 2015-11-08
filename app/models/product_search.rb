# == Schema Information
#
# Table name: product_searches
#
#  id         :integer          not null, primary key
#  term       :string
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductSearch < ActiveRecord::Base
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'

  def self.top_ten
    select('term, count(id) as term_count').group(:term).order('term_count DESC').limit(10)
  end
end
