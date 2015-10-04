require "rails_helper"

describe ServiceProductDecorator do

  describe "#duration" do
    it "adds 'mins' to the total minute duration of a service product" do
      product = build_stubbed(:service_product, minute_duration: 40).decorate
      expect(product.duration).to eq "40 mins"
    end
  end

  describe "#display_price" do
    it "adds dollar sign and cents to the price" do
      product = build_stubbed(:service_product, price: 100).decorate
      expect(product.display_price).to eq "$100.00"
    end
  end

  describe "#add_to_cart" do
    it "generates link to add to cart" do
      # todo = build_stubbed(:todo)
      # result = TodoDecorator.new(todo).completion_link
      # markup = Capybara.string(result)
      # markup.should have_css("a[data-method='post'][href='#{todo_completion_path(todo)}']",
                             # text: 'Complete')

    end
  end
end
