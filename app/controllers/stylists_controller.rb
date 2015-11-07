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

    @future_appointments = @stylist.stylist_appointments.in_future.decorate
    @past_appointments = @stylist.stylist_appointments.in_past.decorate
    @cancelled_appointments = @stylist.stylist_appointments.cancelled.decorate
    @projected_revenue = @stylist.projected_revenue

    @addresses = current_user.addresses.order(primary: :desc).decorate
    @clients = @stylist.clients.uniq
    @gallery_photos = @stylist.stylist_photos
  end

  def preview
    @stylist = StylistDecorator.new(User.from_params(params[:id]))
    @service_products = ServiceProductDecorator.decorate_collection(
      @stylist.service_products.page(params[:page]).per(15)
    )
    @review = StylistReview.new
    @reviews = @stylist.stylist_reviews
    @gallery_photos = @stylist.stylist_photos
  end
end
