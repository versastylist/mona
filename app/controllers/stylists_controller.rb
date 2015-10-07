class StylistsController < ApplicationController
  def show
    @stylist = StylistDecorator.new(User.from_params(params[:id]))
    @service_products = ServiceProductDecorator.decorate_collection(
      @stylist.service_products.page(params[:page]).per(15)
    )
  end
end
