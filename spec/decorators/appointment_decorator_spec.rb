require 'rails_helper'

describe AppointmentDecorator do
  include Rails.application.routes.url_helpers

  describe "#stylist_link" do
    it "returns link to stylist show page" do
      stylist = create(:stylist)
      appt = create(:appointment, stylist: stylist)

      result = described_class.new(appt).stylist_link
      markup = Capybara.string(result)
      expect(markup).to have_css(
        "a[href='#{stylist_path(stylist)}']",
        text: stylist.username
      )
    end
  end

  describe "#client_link" do
    it "returns link to stylist show page" do
      client = create(:client)
      appt = create(:appointment, client: client)

      result = described_class.new(appt).client_link
      markup = Capybara.string(result)
      expect(markup).to have_css(
        "a[href='#{user_path(client)}']",
        text: client.username
      )
    end
  end
end
