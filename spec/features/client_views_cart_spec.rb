require 'rails_helper'

feature 'client views shopping cart' do
  scenario 'when there are no items in cart' do
    client = create(:client)
    sign_in client

    within(:css, '.navbar') do
      click_on 'Cart'
    end

    expect(page).to have_content('Shopping Cart')
    expect(page).to have_content('There are no services in your cart')
  end
end
