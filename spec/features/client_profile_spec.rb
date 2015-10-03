require 'rails_helper'

feature 'client visits profile' do
  scenario 'gets redirected to registration if not complete' do
    client = create(:client)
    sign_in client

    visit user_path(client)

    expect(page).to have_content('Must finish registration before you can visit profile')
  end
end
