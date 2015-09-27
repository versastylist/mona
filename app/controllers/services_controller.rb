class ServicesController < ApplicationController
  def new
    @service = Service.new
  end

  def create
    @service = current_user.services.new(service_params)
    if @service.save
      redirect_to root_path, success: "Successfully added services."
    else
      render 'new'
    end
  end

  private

  def service_params
    params.require(:service).permit(
      :service_menu_id,
      service_products_attributes: [
        :name,
        :hours,
        :minutes,
        :price,
        :details,
        :preparation_instructions<
        :_destroy # Needed for cocoon
      ]
    )
  end
end
