require 'rails_helper'

feature 'client enters their payment info' do
  context 'successfully' do
    let(:client) { FactoryGirl.create(:client) }
    before { sign_in client }

    scenario 'successfully enters payment info', js: true do
      visit new_payment_info_path

      fill_in 'card_number', with: '4242424242424242'
      fill_in 'card_code', with: '343'
      select "#{Date.today.year + 1}", from: 'card_year'

      click_on 'Save Credit Card'
      expect(page).to_not have_content('There was a problem with your payment information.')
    end
  end

  context 'skips payment info' do
    scenario 'skips payment info part' do
      new_client = FactoryGirl.create(:client)
      FactoryGirl.create(:registration, user: new_client)
      sign_in new_client

      visit new_payment_info_path

      click_on 'Skip Payment Info'
      expect(page).to have_content('Services')
      expect(page).to have_content("You still havn't finished your registration. Click here to finish")
    end
  end
end
