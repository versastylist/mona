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
    expect(page).to have_content('Registration')
  end

  context 'successfully' do
    scenario 'fills out registration' do
      client = FactoryGirl.create(:client)
      sign_in client

      visit new_registration_path

      fill_in 'First name', with: 'Johnny'
      fill_in 'Last name', with: 'Jones'
      fill_in 'Phone number', with: '6178945641'
      page.find('#registration_dob').set("06/19/1992")
      select 'Male', from: 'Gender'

      # Address nested form
      fill_in 'Zip code', with: '02460'
      fill_in 'Address', with: '1 Congress St'
      fill_in 'City', with: 'Boston'
      select 'Massachusetts', from: 'State'

      click_on 'Register'

<<<<<<< HEAD:spec/features/client_registers_spec.rb
      expect(page).to have_content('Just a few questions to get started')
      expect(client.registration.first_name).to eq 'Johnny'
      expect(client.registration.last_name).to eq 'Jones'
      expect(client.registration.phone_number).to eq '6178945641'
      # add dob
      expect(client.registration.gender).to eq 'Male'
      expect(client.registration.timezone).to eq 'East'
=======
      expect(page).to have_content('Successfully registered.')
      expect(page).to have_content('Payment Information')
>>>>>>> 39ee96998835ac8b7a239753612e58d67a8003e5:spec/features/user_registers_spec.rb
    end
  end

  context 'skips registration' do
    let(:client) { FactoryGirl.create(:client) }
    before { sign_in client }

    scenario 'presses skip button' do
      visit new_registration_path
      click_on 'Skip Registration'

      expect(page).to have_content('Service Menu')
      expect(page).to have_content("You still havn't finished your registration. Click here to finish")
    end

    scenario 'visits warning link to finish next phase of registration' do
      visit root_path
      click_on 'Click here to finish'
      expect(page).to have_content 'Registration'
    end
  end
end
