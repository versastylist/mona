module StylistSearch
  extend ActiveSupport::Concern

  included do
    searchkick

    def self.elastic_search(params)
      params ? self.search(params) : self.all
    end
  end
end
