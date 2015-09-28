require 'rails_helper'

feature 'stylist finishes registration' do
  scenario 'they get redirected to their profile page at /users/:id' do
    client = FactoryGirl.create(:stylist, username: 'jamesbond')
    sign_in client
    visit new_registration_path

    fill_in 'First name', with: 'Johnny'
    fill_in 'Last name', with: 'Jones'
    fill_in 'Phone number', with: '6178945641'
    page.find('#registration_dob').set("06/19/1992")
    select 'Male', from: 'Gender'

    # Address sub form
    fill_in 'Zip code', with: '02460'
    fill_in 'Address', with: '1 Congress St'
    fill_in 'City', with: 'Boston'
    select 'Massachusetts', from: 'State'

    click_on 'Register'

    expected_url = ".com/payment_infos/new"
    expect(current_url).to match(Regexp.new(expected_url))
  end
end
