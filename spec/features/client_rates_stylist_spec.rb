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

      select 5, from: 'Rating'
      fill_in 'Body', with: 'Did a great job giving me a haircut!'
      click_on 'Add Review'

      expect(page).to have_content('Successfully created review')
      expect(page).to have_content(5)
    end

    scenario "can't rate if they havn't had appointment" do

    end
  end
end
