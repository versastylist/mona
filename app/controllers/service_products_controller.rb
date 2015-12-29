class ServiceProductsController < ApplicationController
  def edit
    @product = ServiceProduct.find(params[:id])
  end

  def update
    @product = ServiceProduct.find(params[:id])

    if @product.update_attributes(product_params)
      respond_to do |f|
        f.json { render json: @product  }
        f.html { redirect_to stylist_path(current_user), success: 'Updated service product' }
      end
    else
      respond_to do |f|
        f.json { render json: { errors: @product.errors.full_messages }, status: 500 }
        f.html { render :edit }
      end
    end
  end

  private

  def product_params
    params.require(:service_product).permit(
      :displayed,
      :name,
      :hours,
      :minutes,
      :price,
      :details,
      :preparation_instructions
    )
  end
end
