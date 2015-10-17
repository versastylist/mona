require 'rails_helper'

feature 'client books an appointment with stylist' do
  context 'authenticated client' do
    let(:client) { create(:client, :with_registration)  }
    let(:stylist) { create(:stylist, :with_registration) }

    scenario 'successfully', js: true do
      open_schedule_for_stylist(stylist)
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
      find(:css, "a.fc-time-grid-event").click

      click_on 'Book Appointment'
      expect(page).to have_content 'Successfully booked appointment'
    end
  end
end
