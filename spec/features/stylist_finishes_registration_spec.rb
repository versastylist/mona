require 'rails_helper'

feature 'stylist finishes registration' do
  scenario 'they get redirected to their profile page at /users/:id' do
    client = FactoryGirl.create(:stylist, username: 'jamesbond')
    sign_in client
    visit new_registration_path

    fill_in 'First name', with: 'Johnny'
    fill_in 'Last name', with: 'Jones'
    fill_in 'Cell Phone', with: '6178945641'
    page.find('#registration_dob').set("1992/06/19")
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

  scenario "stylists don't see the 'find service' button in nav bar" do
    stylist = create(:stylist, :with_registration)
    sign_in stylist

    within(:css, '.navbar-right') do
      expect(page).to_not have_content 'Find Service'
    end
  end

  scenario "stylists cannot skip registration" do
    stylist = create(:stylist)
    sign_in stylist

    visit new_registration_path
    expect(page).to_not have_content('Skip Registration')
  end
end
