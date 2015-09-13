require 'rails_helper'

feature 'stylist sign up' do
  context 'successfully' do
    scenario 'provide valid registration information' do
      visit root_path
      click_on 'Sign up as stylist'

      fill_in 'Username', with: 'johnny'
      fill_in 'Email', with: 'john@example.com'
      fill_in 'Password', with: 'supersecret'
      fill_in 'Password confirmation', with: 'supersecret'
      find(:css, "#user_agree_to_terms").set(true)

      click_button 'Sign up'

      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_content('Sign Out')
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

