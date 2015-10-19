class ServiceProductsController < ApplicationController
  def update
    @product = ServiceProduct.find(params[:id])

    if @product.update_attributes(product_params)
      render json: @product
    else
      render json: { errors: @product.errors.full_messages }, status: 422
    end
  end

  private

  def product_params
    params.require(:service_product).permit(:displayed)
  end
end
