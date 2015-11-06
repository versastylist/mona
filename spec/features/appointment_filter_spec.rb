require 'rails_helper'

feature 'user searching for appointments' do
  context 'search with keyword' do
    let(:client) { create(:client, :with_registration) }
    before { sign_in client }

    scenario 'finds the service products that have the keyword' do
      stylist = create(:stylist, :with_registration)
      create_addresses_within_range(client, stylist)
      create_service_product(stylist,
                             name: 'Buzz cut',
                             details: 'A buzz cut for kids')

      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      fill_in 'product-search', with: 'buzz cut'
      click_on 'Search'

      expect(page).to have_content('A buzz cut for kids')
    end

    it "doesn't find products that are disabled by stylists" do
      stylist = create(:stylist, :with_registration)
      create_addresses_within_range(client, stylist)
      create_service_product(
        stylist,
        name: 'Buzz cut',
        details: 'A buzz cut for kids'
      )
      create_service_product(
        stylist,
        name: 'Adult buzz cut',
        details: 'Military style buzz',
        displayed: false
      )
      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      fill_in 'product-search', with: 'buzz cut'
      click_on 'Search'

      expect(page).to have_content('A buzz cut for kids')
      expect(page).to_not have_content('Military style buzz')
    end

    scenario "doesnt find products from stylists who have disabled booking" do
      stylist = create(:stylist, :with_registration, :disabled)
      create_addresses_within_range(client, stylist)
      create_service_product(stylist,
                             name: 'Buzz cut',
                             details: 'A buzz cut for kids')

      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      fill_in 'product-search', with: 'buzz cut'
      click_on 'Search'

      expect(page).to_not have_content('A buzz cut for kids')
    end
  end

  context 'unregistered client' do
    let(:client) { create(:client) }
    before { sign_in client }

    scenario 'it shows an address form' do
      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      expect(page).to have_content('Address required if not yet done with registration')
    end

    scenario 'it lets client search with temp address' do
      stylist = create(:stylist, :with_registration)
      address = create(:address, user: stylist)
      create_service_product(stylist,
                             name: 'Buzz cut',
                             details: 'A buzz cut for kids')

      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      fill_in 'product-search', with: 'buzz cut'
      fill_in 'Address', with: address.address
      fill_in 'City', with: address.city
      fill_in 'Zip code', with: address.zip_code
      select address.state, from: 'State'

      click_on 'Search'
      expect(page).to have_content('A buzz cut for kids')
    end
  end
end

def create_addresses_within_range(client, stylist)
  create(:address, user: client)
  create(:address, user: stylist)
end
