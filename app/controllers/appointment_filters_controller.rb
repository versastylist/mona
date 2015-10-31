class AppointmentFiltersController < ApplicationController
  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])

    if params[:query]
      upper_bound     = find_upper_bound
      geocoordinates  = find_search_address
      service_ids     = User.available_service_ids(geocoordinates, 5)

      if !params[:query].blank?
        @service_products = ServiceProductDecorator.decorate_collection(
          ServiceProduct.search(
            params[:query],
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
      else
        @service_products = ServiceProductDecorator.decorate_collection(
          ServiceProduct.displayed.less_than(upper_bound).
          joins(:service).where(
            services: { service_menu_id: @service_menu.id }
          ).where(service_id: service_ids).page(params[:page]).per(10)
        )
      end
    end
  end

  private

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
