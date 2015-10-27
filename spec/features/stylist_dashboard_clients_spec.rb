require 'rails_helper'

feature 'stylist dashboard client tab' do
  let(:stylist) { create(:stylist, :with_registration) }
  before { sign_in stylist }

  scenario 'lists all clients stylist has serviced', js: true do
    client = create(:client, :with_registration)
    create(:appointment, stylist: stylist, client: client)

    visit stylist_path(stylist)
    click_on 'Clients'

    expect(page).to have_content(client.first_name)
    expect(page).to have_content(client.last_name)
    expect(page).to have_content(client.phone_number)
    expect(page).to_not have_content(client.dob)
  end

  scenario 'lists clients birthday if premium member', js: true do
    client = create(:client, :with_registration)
    create(:appointment, stylist: stylist, client: client)
    stylist.premium_membership = true
    stylist.save

    visit stylist_path(stylist)
    click_on 'Clients'

    expect(page).to have_content(client.dob)
  end

  scenario 'stylists can search for clients by name', js: true do
    registration = create(:registration, first_name: 'Batman')
    client = create(:client, registration: registration)
    create(:appointment, stylist: stylist, client: client)

    visit stylist_path(stylist)
    click_on 'Clients'

    fill_in 'clientSearch', with: 'Batman'
    find('#clientSearch').native.send_keys(:return)

    expect(page).to have_content('Batman')
  end
end
