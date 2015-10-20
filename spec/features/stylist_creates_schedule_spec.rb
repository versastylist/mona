require 'rails_helper'

feature 'stylist creates a weekly schedule' do
  let(:stylist) { create(:stylist, :with_registration) }

  context 'successfully' do
    before { sign_in stylist }

    scenario 'without intervals', js: true do
      visit stylist_path(stylist)

      click_on 'Schedule'
      click_on 'Add Schedule'
      click_on 'Create Schedule'

      expect(page).to have_content('Successfully created schedule')
    end

    scenario 'with intervals', js: true do
      visit stylist_path(stylist)

      click_on 'Schedule'
      click_on 'Add Schedule'

      current_day = DateTime.now.in_time_zone.strftime('%A').downcase

      within(:css, "#week_1_#{current_day}") do
        find(:css, 'a.add_fields:first-child').click
        fill_in 'Title', with: 'Lunch'
      end

      click_on 'Create Schedule'

      expect(page).to have_content('Successfully created schedule')
    end

    scenario 'displayed on their dashboard page', js: true do
      create_default_schedule(stylist)
      visit stylist_path(stylist)

      click_on 'Schedule'
      expect(page).to have_css('#event_id_1')
    end
  end
end

def create_default_schedule(stylist)
  visit stylist_path(stylist)

  click_on 'Schedule'
  click_on 'Add Schedule'
  click_on 'Create Schedule'
end
