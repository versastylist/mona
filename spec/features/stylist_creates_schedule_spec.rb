require 'rails_helper'

feature 'stylist creates a weekly schedule' do
  let(:stylist) { FactoryGirl.create(:registered_stylist) }

  # not going to build feature specs for this until the process is more
  # solidified

  scenario 'successfully', js: true
    # sign_in stylist
    # visit stylist_path(stylist)

    # click_on 'Schedule'
    # click_on 'Add Weekly Schedule'

    # fill_in 'Name', with: 'Normal Schedule'

    # click_on 'Create Schedule'
    # expect(page).to have_content('Successfully created schedule')
  # end
end
