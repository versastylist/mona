require 'rails_helper'

feature 'admin can see list of stylists' do
  scenario 'successfully' do
    admin = create(:admin)
    sign_in admin

    visit admin_stylists_path
    expect(page).to have_content('All Stylists')
  end
end
