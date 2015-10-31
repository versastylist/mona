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
end
