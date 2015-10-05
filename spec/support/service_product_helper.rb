module ServiceProductHelper
  # def create_stylist_with_products(*products)
    # stylist = create(:stylist, :with_registration)
    # products.each do |prod|
      # create_service_product(stylist, {name: prod})
    # end
  # end

  def create_service_product(stylist, options = {})
    options = service_product_defaults.merge(options)

    service = create(:service, stylist: stylist)
    options[:service] = service

    product = create(:service_product, options)
    ServiceProduct.reindex
    ServiceProduct.searchkick_index.refresh
    product
  end

  private

  def service_product_defaults
    {
      name: 'Buzz cut',
      minutes: 30,
      hours: 0,
      price: 25,
      details: 'A buzz cut for kids',
      preparation_instructions: 'Be prepared to have no more hair',
      minute_duration: 30,
      displayed: true
    }
  end
end
