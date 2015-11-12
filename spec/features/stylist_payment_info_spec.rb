require 'rails_helper'

feature 'stylist enters their banking information' do
  context 'successfully' do
    let(:stylist) { FactoryGirl.create(:stylist) }
    before { sign_in stylist }

    # TODO: Figure out how to properly mock out Stripe for testing
    # scenario 'successfully enters payment info', js: true do
      # visit new_payment_info_path

      # fill_in 'full_name', with: 'Spencer Dixon'
      # fill_in 'bank_name', with: 'Stripe Test Bank'
      # fill_in 'routing_number', with: '110000000'
      # fill_in 'account_number', with: '000123456789'

      # click_on 'Save Bank Information'
      # expect(page).to_not have_content('There was a problem with your payment information.')
    # end
  end

  context 'skips payment info' do
    scenario 'skips payment info part' do
      new_stylist = FactoryGirl.create(:stylist)
      FactoryGirl.create(:registration, user: new_stylist)
      sign_in new_stylist

      visit new_payment_info_path

      click_on 'Skip Payment Info'
      expect(page).to have_content('Service Menu')
      expect(page).to have_content("You still haven't finished your registration. Click here to finish")
    end
  end
end
