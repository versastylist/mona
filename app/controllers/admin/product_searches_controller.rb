class Admin::ProductSearchesController < ApplicationController
  def index
    @searches = ProductSearch.top_ten
  end
end
