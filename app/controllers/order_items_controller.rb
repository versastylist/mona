class OrderItemsController < ApplicationController
  before_action :verify_completed_registration!
  before_action :verify_not_guest!

  def create
    @stylist = User.from_params(stylist_id)

    if !@stylist.allow_multiple_services? && current_order.persisted?
      redirect_to :back, warning: "Stylist only allows 1 service at a time."
    else
      @order = current_order
      @order_item = @order.order_items.new(order_item_params)
      @order.save
      session[:order_id] = @order.id
      redirect_to :back, success: "Added service to cart"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :service_product_id)
  end

  def stylist_id
    params[:order_item][:stylist_id]
  end
end
