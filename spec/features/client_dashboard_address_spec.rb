require 'rails_helper'

feature 'settings tab' do
  context 'addresses' do
    let(:client) { create(:client, :with_registration) }
    before { sign_in client }

    scenario 'let client add an additional address' do
      visit user_path(client)
      click_on 'Settings'
      click_on 'Add Address'

      # Address nested form
      fill_in 'Zip code', with: '02460'
      fill_in 'Address', with: '1 Congress St'
      fill_in 'City', with: 'Boston'
      select 'Massachusetts', from: 'State'

      click_on 'Create Address'
      expect(page).to have_content('Successfully added address')
      expect(current_url).to eq user_url(client)
    end

    scenario 'let client edit address', js: true do
      create(:address, user: client)
      visit user_path(client)

      click_on 'Settings'

      click_on 'Edit'

      fill_in 'City', with: 'Cambridge'
      click_on 'Update'

      expect(page).to have_content('Successfully updated address')
    end
  end
end
