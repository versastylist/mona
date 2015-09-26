require 'rails_helper'

feature 'stylist creates a weekly schedule' do
  let(:stylist) { FactoryGirl.create(:registered_stylist) }

  scenario 'successfully', js: true do
    sign_in stylist
    visit stylist_path(stylist)

    click_on 'Schedule'
    click_on 'Add Weekly Schedule'

    fill_in 'Name', with: 'Normal Schedule'

    click_on 'Create Schedule'
    expect(page).to have_content('Successfully created schedule')
  end
end
