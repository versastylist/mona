require 'rails_helper'

feature 'client books an appointment with stylist' do
  context 'authenticated client' do
    let(:client) { create(:client, :with_registration)  }
    let(:stylist) { create(:stylist, :with_registration) }

    scenario 'successfully', js: true do
      # Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
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
        # find(:css, '.fc-icon-right-single-arrow').click # Needed to add this at end of month
        find(:css, "#event_id_1_0").click

        click_on 'Book Appointment'
        expect(page).to have_content 'Successfully booked appointment'
      # end
    end

    scenario 'cant book when stylist has no current schedule' do
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
      expect(page).to_not have_content('Book Appointment')
    end
  end

  scenario 'stylist only allows 1 service' do
    client = create(:client, :with_registration)
    stylist = create(:stylist, :with_registration)
    stylist.settings.update(multiple_services: false)

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

    within(:css, "#service_product_#{product.id}") do
      click_on 'Add To Cart'
    end
    expect(page).to have_content('Stylist only allows 1 service at a time.')
  end
end
