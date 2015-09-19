class PaymentInfosController < ApplicationController
  before_action :authenticate_user!

  def new
    @payment_info = PaymentInfo.new
  end

  def create
    @payment_info = current_user.build_payment_info(payment_params)

    if @payment_info.save_with_payment
      flash[:success] =  "Payment info saved!"
    end
    redirect_to root_path
  end

  def payment_params
    params.require(:payment_info).permit(:stripe_card_token, :stripe_bank_token)
  end
end
