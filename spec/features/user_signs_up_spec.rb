require 'rails_helper'

feature 'client signs up' do
  context 'successfully' do
    scenario 'provide valid registration information' do
      visit root_path
      click_on 'Sign up as client'

      fill_in 'Username', with: 'johnny'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'supersecret'
      fill_in 'Password confirmation', with: 'supersecret'
      find(:css, "#user_agree_to_terms").set(true)

      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_link('Sign Out')
    end

    scenario 'and they click on terms of service button' do
      # clicking link opens new tab. Just going to test the link displays right
      # info
      visit client_terms_of_service_path
      expect(page).to have_content('Client Terms of Service')
    end
    scenario 'and they click on terms of service button' do
      # clicking link opens new tab. Just going to test the link displays right
      # info
      visit stylist_terms_of_service_path
      expect(page).to have_content('Stylist Terms of Service')
    end
  end

  context 'unsuccessfully' do
    scenario 'provides too short of a username' do
      visit root_path
      click_on 'Sign up as client'

      fill_in 'Username', with: 'j'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Sign up'

      expect(page).to have_content('Username is too short')
    end

    scenario 'username cannot contain spaces and requires email' do
      visit root_path
      click_on 'Sign up as client'

      fill_in 'Username', with: 'johnny jones'
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Sign up'

      expect(page).to have_content('Username cannot contain spaces')
      expect(page).to have_content("Email can't be blank")
    end

    scenario 'need to agree to terms' do
      visit root_path
      click_on 'Sign up as client'
      click_button 'Sign up'

      expect(page).to have_content("terms can't be blank")
    end
  end
end

