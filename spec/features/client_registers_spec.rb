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

  end
end
