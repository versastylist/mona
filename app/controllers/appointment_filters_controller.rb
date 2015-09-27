class AppointmentFiltersController < ApplicationController
  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
    if params[:query]
      @service_products = ServiceProduct.search(
        params[:query],
        page: params[:page],
        per_page: 2,
        where: {
          service_menu: [@service_menu.name]
        }
      )
    end
  end
end
