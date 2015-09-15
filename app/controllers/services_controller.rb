class ServicesController < ApplicationController
  def index
    @services = ['haircut', 'coloring', 'styling']
  end
end
