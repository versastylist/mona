require 'rails_helper'

feature 'client books an appointment with stylist' do
  context 'authenticated client' do
    let(:client) { create(:client, :with_registration)  }
    let(:stylist) { create(:stylist, :with_registration) }

    scenario 'successfully' do
      stylist_schedule = open_schedule_for_stylist(stylist)
      product = create_service_product(
        stylist,
        name: 'Buzz cut',
        minute_duration: 60
      )
      sign_in client
      visit stylist_path(stylist)

      within(:css, "#service_product_#{product.id}") do
        click_on 'Add To Cart'
      end
      expect(page).to have_content('Added service to cart')

      click_on 'Book Appointment'
      click_on 'Morning'
    end
  end
end
