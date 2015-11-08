require 'rails_helper'

feature 'stylist adds a service product offering' do
  context 'successfully' do
    let(:stylist) { create(:stylist, :with_registration) }

    before do
      create(:service_menu, name: 'Barber')
      sign_in stylist
    end

    scenario 'adds a single service', js: true, callbacks: true do
      visit stylist_path(stylist)
      click_on 'Services'
      click_on 'Add Service'

      select 'Barber', from: 'Service Menu'
      click_on 'Add New Product'

      fill_in 'Name', with: 'Buzz cut'
      select 0, from: 'Hours'
      select 30, from: 'Minutes'
      fill_in 'Price', with: 50
      fill_in 'Details', with: 'A quick buzz cut'
      fill_in 'Preparation instructions', with: 'None'

      click_on 'Create Services'

      expect(page).to have_content('Successfully added services.')
      expect(page).to have_content("#{stylist.username}'s profile")
    end
  end

  context 'unsuccessfully' do
    let(:stylist) { create(:stylist, :with_registration) }

    before do
      create(:service_menu, name: 'Barber')
      sign_in stylist
    end

    scenario 'it displays service menu error' do
      visit new_service_path
      click_on 'Create Services'

      expect(page).to have_content("Service menu can't be blank")
    end

    scenario 'it displays service product errors', js: true do
      visit new_service_path

      select 'Barber', from: 'Service Menu'
      click_on 'Add New Product'

      click_on 'Create Services'
      expect(page).to have_content("Service products name can't be blank")
      expect(page).to have_content("Service products price can't be blank")
      expect(page).to have_content("Service products price is not a number")
    end
  end
end
