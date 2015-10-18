require 'rails_helper'

feature 'client rates stylist after appointment' do
  context 'authenticated user' do
    let(:client) { create(:client, :with_registration) }
    let(:stylist) { create(:stylist, :with_registration) }

    scenario 'rates successfully', js: true do
      create(:appointment, client: client, stylist: stylist)
      sign_in client

      visit stylist_path(stylist)
      click_on 'Reviews'

      find(:css, "a[data-rating='4']").click
      fill_in 'Review', with: 'Did a great job giving me a haircut!'
      click_on 'Create Review'

      expect(page).to have_content('Successfully created review')
      expect(page).to have_content('4.0 / 5')
    end

    scenario "can't rate if they havn't had appointment", js: true do
      sign_in client

      visit stylist_path(stylist)
      click_on 'Reviews'

      expect(page).to have_content('Must have had appointment with stylist to leave review')
    end
  end
end
