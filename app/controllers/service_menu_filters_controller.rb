class ServiceMenuFiltersController < ApplicationController
  def index
    @service_menus = ServiceMenu.all
  end
end
