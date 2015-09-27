class AppointmentFiltersController < ApplicationController
  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
  end
end
