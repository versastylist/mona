class OrderItemsController < ApplicationController
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

  # def update
    # @order = current_order
    # @order_item = @order.order_items.find(params[:id])
    # @order_item.update_attributes(order_item_params)
    # @order_items = @order.order_items
  # end

  # def destroy
    # @order = current_order
    # @order_item = @order.order_items.find(params[:id])
    # @order_item.destroy
    # @order_items = @order.order_items
  # end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :service_product_id)
  end

  def stylist_id
    params[:order_item][:stylist_id]
  end
end
