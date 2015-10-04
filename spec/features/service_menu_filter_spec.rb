require 'rails_helper'

feature 'user picks service menu for filter' do
  let(:client) { create(:client, :with_registration) }
  before { sign_in client }

  scenario 'selects Barber successfully' do
    FactoryGirl.create(:service_menu, name: 'Barber')

    visit menu_filters_path
    click_on 'barber'

    expect(page).to have_content('Find Appointment For Barber')
  end

  scenario 'can start filtering process from nav bar' do
    within(:css, '.navbar') do
      click_on 'Find Service'
    end

    expect(page).to have_content('Service Menu')
  end
end
