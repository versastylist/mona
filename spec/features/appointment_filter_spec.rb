require 'rails_helper'

feature 'user searching for appointments' do
  context 'search with keyword' do
    let(:client) { create(:client, :with_registration) }
    before { sign_in client }

    scenario 'finds the service products that have the keyword' do
      stylist = create(:stylist, :with_registration)
      create_service_product(stylist,
                             name: 'Buzz cut',
                             details: 'A buzz cut for kids')

      menu = create(:service_menu, name: 'Barber')
      visit menu_filter_appointments_path(menu)

      fill_in 'product-search', with: 'buzz cut'
      click_on 'Search'

      expect(page).to have_content('A buzz cut for kids')
    end
  end
end