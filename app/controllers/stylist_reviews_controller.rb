class StylistReviewsController < ApplicationController
  def create
    @review = current_user.client_reviews.new(review_params)

    if @review.save
      flash[:success] = 'Successfully created review'
    end
    redirect_to stylist_path(@review.stylist)
  end

  private

  def review_params
    params.require(:stylist_review).permit(:rating, :body, :stylist_id)
  end
end
