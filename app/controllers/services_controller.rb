class ServicesController < ApplicationController
  def new
    @service = Service.new
  end

  def create
    @service = current_user.services.new(service_params)
    if @service.save
      redirect_to stylist_path(current_user),
        success: "Successfully added services."
    else
      render 'new'
    end
  end

  private

  def no_service_products?
    !params[:service][:service_product_attributes].present?
  end

  def service_params
    params.require(:service).permit(
      :service_menu_id,
      service_products_attributes: [
        :name,
        :hours,
        :minutes,
        :price,
        :details,
        :preparation_instructions,
        :_destroy # Needed for cocoon
      ]
    )
  end
end
