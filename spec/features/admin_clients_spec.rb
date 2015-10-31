require 'rails_helper'

feature 'admin can see list of clients' do

  scenario 'successfully' do
    admin = create(:admin)
    sign_in admin

    visit admin_clients_path
    expect(page).to have_content('All Clients')
  end
end
