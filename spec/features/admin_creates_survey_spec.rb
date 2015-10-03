require 'rails_helper'

feature 'admin creates a survey' do
  context 'when authenticated as admin' do
    let(:admin) { create(:admin) }
    scenario 'successfully' do
      sign_in admin

      visit new_admin_survey_path
      fill_in 'Title', with: 'Client Registration'

      click_on 'Create Survey'
      expect(page).to have_content('Successfully created survey')
      expect(page).to have_content('Client Registration')
    end

    scenario 'missing required fields shows errors'
  end

  context 'unauthenticated users' do
    scenario 'get redirected to root path' do
      user = create(:client, :with_registration)
      sign_in user

      visit new_admin_survey_path
      expect(page).to have_content 'No longer available'
    end
  end
end
