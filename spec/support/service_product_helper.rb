module ServiceProductHelper
  def create_service_product(stylist, options = {})
    options = service_product_defaults.merge(options)

    service = FactoryGirl.create(:service, stylist: stylist)
    options[:service] = service

    product = FactoryGirl.create(:service_product, options)
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
