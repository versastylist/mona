class StylistsController < ApplicationController
  def show
    @stylist = StylistDecorator.new(User.from_params(params[:id]))
    @service_products = @stylist.service_products.decorate
  end
end
