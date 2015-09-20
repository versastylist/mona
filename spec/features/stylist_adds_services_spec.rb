require 'rails_helper'

feature 'stylist adds a service product offering' do
  context 'successfully' do
    scenario 'adds a single service' do
      stylist = FactoryGirl.create(:registered_stylist)
      sign_in stylist

      visit user_path(stylist)

      click_on 'Add Service'

      select 'Barber', from: 'Service Categories'
      fill_in 'Name', with: 'Buzz cut'
      fill_in 'Hours', with: 0
      fill_in 'Minutes', with: 30
      fill_in 'Price', with: 30
      fill_in 'Details', with: 'A quick buzz cut'
      fill_in 'Preparation Instructions', with: 'None'

      click_on 'Add Services'

      expect(page).to have_content('Services successfully added')
    end
  end
end
