class StylistsController < ApplicationController
  def show
    @stylist = StylistDecorator.new(User.from_params(params[:id]))
    @service_products = ServiceProductDecorator.decorate_collection(
      @stylist.service_products.page(params[:page]).per(15)
    )
    @review = StylistReview.new
    @reviews = @stylist.stylist_reviews
    @event_sources = StylistScheduleDisplayer.new(@stylist).
      find_times.to_json if @stylist.current_schedule.present?
  end
end
