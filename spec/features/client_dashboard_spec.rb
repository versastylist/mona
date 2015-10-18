require 'rails_helper'

feature 'client dashboard' do
  context 'settings' do
    scenario 'visits setting page to update phone', js: true do
      client = create(:client, :with_registration)
      sign_in client

      click_on 'Profile'
      click_on 'Settings'

      fill_in 'Phone number', with: '5551113456'
      click_on 'Edit Registration'

      expect(page).to have_content('Updated registration details')
    end
  end

  context 'appointments' do
    scenario 'lists future appointments' do
      
    end
  end
end
