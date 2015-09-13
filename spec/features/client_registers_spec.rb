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
      visit new_client_registration_path

      fill_in 'First name', with: 'Johnny'
      fill_in 'Last name', with: 'Jones'
      fill_in 'Phone number', with: '6178945641'
      # select_date '09/01/2015', from: 'Date of birth'
      select 'Male', from: 'Gender'

      # TODO: finish this
    end
  end
end
