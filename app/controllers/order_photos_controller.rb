class OrderPhotosController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @photo = @order.order_photos.new(photo_params)

    if @photo.save
      flash[:success] = "Added photo for stylist to see"
    else
      flash[:warning] = "Something went wrong uploading your photo"
    end
    redirect_to :back
  end

  private

  def photo_params
    params.require(:order_photo).permit(:image, :description, :purpose)
  end
end
