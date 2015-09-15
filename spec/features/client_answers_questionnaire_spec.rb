require 'rails_helper'

feature 'client answers questionnaire' do
  context 'successfully' do
    scenario 'completes registration' do
      client = FactoryGirl.create(:client)
      sign_in client

      visit new_client_registration_path

      fill_in 'First name', with: 'Johnny'
      fill_in 'Last name', with: 'Jones'
      fill_in 'Phone number', with: '6178945641'
      page.find('#client_registration_dob').set("06/19/1992")
      select 'Male', from: 'Gender'
      select 'East', from: 'Timezone'
      click_on 'Register'

      expect(page).to have_content('Successfully registered.')
      # visit new_user_questionnaire_path
      expect(page).to have_content('Just a few questions to get started')
      # expect(client.first_name)to eq 'Johnny'

      expect(page).to have_link('skip')

      find(:css, "#service-children").set(true)
      find(:css, "#have-pets").set(true)
      find(:css, "#indoor-smoker").set(true)
      find(:css, "#place-carpeted").set(true)
      find(:css, "#medical-skin-conditions").set(true)

      click_on 'Submit'
      # expect(client)
    end
  end
end
