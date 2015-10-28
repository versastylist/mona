require 'rails_helper'

feature 'stylist can preview their profile to client view' do
  scenario 'successfully' do
    stylist = create(:stylist, :with_registration)
    sign_in stylist

    visit stylist_path(stylist)
    click_on 'Client View'
    expect(page).to have_content('WARNING! You are in client preview mode')
  end
end
