class ProductSearch < ActiveRecord::Base
  belongs_to :client, class_name: 'User', foreign_key: 'client_id'

  def self.top_ten
    select('term, count(id) as term_count').group(:term).order('term_count DESC').limit(10)
  end
end
