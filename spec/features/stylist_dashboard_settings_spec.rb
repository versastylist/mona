require 'rails_helper'

feature 'settings tab' do
  context 'switch buttons include' do
    let(:stylist) { create(:stylist, :with_registration) }
    before do
      sign_in stylist
      visit stylist_path(stylist)
      click_on 'Settings'
    end

    scenario 'option to enable/disable booking' do
      expect(page).to have_css('#enableBooking')
    end

    scenario 'option to allow multiple service booking' do
      expect(page).to have_css('#multipleServices')
    end

    scenario 'option to receive texts when clients book' do
      expect(page).to have_css('#receiveTexts')
    end

    scenario 'option to receive emails when clents book' do
      expect(page).to have_css('#receiveEmails')
    end
  end

  context 'addresses' do
    let(:stylist) { create(:stylist, :with_registration) }
    before { sign_in stylist }

    scenario 'let stylist add an additional address' do
      visit stylist_path(stylist)
      click_on 'Settings'
      click_on 'Add Address'

      # Address nested form
      fill_in 'Zip code', with: '02460'
      fill_in 'Address', with: '1 Congress St'
      fill_in 'City', with: 'Boston'
      select 'Massachusetts', from: 'State'

      click_on 'Create Address'
      expect(page).to have_content('Successfully added address')
      expect(current_url).to eq stylist_url(stylist)
    end

    scenario 'let stylist edit address', js: true do
      create(:address, user: stylist)
      visit stylist_path(stylist)

      click_on 'Settings'

      click_on 'Edit'

      fill_in 'City', with: 'Cambridge'
      click_on 'Update'

      expect(page).to have_content('Successfully updated address')
    end
  end
end
