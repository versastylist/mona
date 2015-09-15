require 'rails_helper'

feature 'client registration' do
  scenario 'client gets directed to complete registration after sign up' do
    visit root_path
    click_on 'Sign up as client'

    fill_in 'Username', with: 'johnny'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'supersecret'
    fill_in 'Password confirmation', with: 'supersecret'
    find(:css, "#user_agree_to_terms").set(true)

    click_button 'Sign up'
    expect(page).to have_content('Client Registration')
  end

  context 'successfully' do
    scenario 'fills out registration' do
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

      expect(page).to have_content('Just a few questions to get started')
    end
  end

  context 'skips registration' do
    let(:client) { FactoryGirl.create(:client) }
    before { sign_in client }

    scenario 'presses skip button' do
      visit new_client_registration_path
      click_on 'Skip Registration'

      expect(page).to have_content('Services')
      expect(page).to have_content("You still havn't finished your registration. Click here to finish")
    end

    scenario 'visits warning link to finish next phase of registration' do
      visit root_path
      click_on 'Click here to finish'
      expect(page).to have_content 'Client Registration'
    end
  end
end