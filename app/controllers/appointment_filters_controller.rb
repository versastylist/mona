class AppointmentFiltersController < ApplicationController
  def new
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
  end

  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
    @service_products = ServiceProduct.search(
      params[:query],
      where: {
        service_menu: [@service_menu.name]
      }
    )
  end
end
