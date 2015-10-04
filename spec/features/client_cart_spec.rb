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

  scenario "client adds item to cart" do
    client = create(:client)
    sign_in client

    stylist = create(:stylist, :with_registration)
    product = create_service_product(stylist, {name: 'Buzz cut', price: 30})

    visit stylist_path(stylist)
    within(:css, "#service_product_#{product.id}") do
      click_on 'Add To Cart'
    end

    visit cart_path
    expect(page).to have_content('Buzz cut')
  end

  scenario "stylists should not see a cart"
end
