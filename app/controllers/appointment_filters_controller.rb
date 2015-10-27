class AppointmentFiltersController < ApplicationController
  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
    @product_search =
    if params[:query]
      upper_bound     = find_upper_bound
      geocoordinates  = find_search_address
      sanitized_query = find_search_query
      service_ids     = User.available_service_ids(geocoordinates, 5)

      @service_products = ServiceProductDecorator.decorate_collection(
        ServiceProduct.search(
          sanitized_query,
          page: params[:page],
          per_page: 10,
          where: {
            service_menu: [@service_menu.name],
            price: {lt: upper_bound},
            service_id: service_ids,
            displayed: true,
          }
        )
      )
    end
  end

  private

  def find_search_query
    params[:query].blank? ? '*' : params[:query]
  end

  def find_upper_bound
    params[:price_range].blank? ? 4000 : params[:price_range].to_i
  end

  def find_search_address
    primary = current_user.primary_address
    return primary.location if primary.present?

    if valid_address
      param_address = TempAddress.new(params[:address]).full_street_address
      Geocoder.coordinates(param_address)
    else
      flash[:danger] = "If you're not registered you need to enter an address to search"
      redirect_to :back
    end
  end

  def valid_address
    !params[:address][:zip_code].blank? && !params[:address][:address].blank?
  end
end
