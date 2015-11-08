class StylistsController < ApplicationController
  before_action :prep_products_and_stylist

  def show
    @review = StylistReview.new
    @reviews = @stylist.stylist_reviews
    @event_sources = StylistScheduleDisplayer.new(@stylist).find_times.to_json

    @future_appointments = @stylist.stylist_appointments.in_future.decorate
    @past_appointments = @stylist.stylist_appointments.in_past.decorate
    @cancelled_appointments = @stylist.stylist_appointments.cancelled.decorate
    @projected_revenue = @stylist.projected_revenue

    @addresses = @stylist.addresses.order(primary: :desc).decorate
    @clients = @stylist.clients.uniq
    @gallery_photos = @stylist.stylist_photos
  end

  def preview
    @review = StylistReview.new
    @reviews = @stylist.stylist_reviews
    @gallery_photos = @stylist.stylist_photos
  end

  def prep_products_and_stylist
    @stylist = StylistDecorator.new(User.from_params(params[:id]))

    @barber           = ServiceProductDecorator.decorate_collection(@stylist.service_products.barber)
    @nails            = ServiceProductDecorator.decorate_collection(@stylist.service_products.nails)
    @hair_cut         = ServiceProductDecorator.decorate_collection(@stylist.service_products.hair_cut)
    @weave            = ServiceProductDecorator.decorate_collection(@stylist.service_products.weave)
    @natural          = ServiceProductDecorator.decorate_collection(@stylist.service_products.natural)
    @blowout_and_sets = ServiceProductDecorator.decorate_collection(@stylist.service_products.blowout_and_sets)
    @makeup           = ServiceProductDecorator.decorate_collection(@stylist.service_products.makeup)
    @specialties      = ServiceProductDecorator.decorate_collection(@stylist.service_products.specialties)
  end
end
