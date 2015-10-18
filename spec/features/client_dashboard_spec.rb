require 'rails_helper'

feature 'client dashboard' do
  context 'settings' do
    scenario 'visits setting page to update phone', js: true do
      client = create(:client, :with_registration)
      sign_in client

      click_on 'Profile'
      click_on 'Settings'

      fill_in 'Phone number', with: '5551113456'
      click_on 'Edit Registration'

      expect(page).to have_content('Updated registration details')
    end
  end

  context 'appointments' do
    let(:client) { create(:client, :with_registration) }
    before { sign_in client }

    scenario 'lists future appointments' do
      appointment = create(:appointment, client: client, start_time: 2.days.from_now)

      visit user_path(client)
      within(:css, '.future-appointments') do
        expect(page).to have_content(formatted_start_time(appointment))
      end
    end

    scenario 'lists past appointments' do
      future = create(:appointment, client: client, start_time: 2.days.from_now)
      past = create(:appointment, client: client, start_time: 2.days.ago)

      visit user_path(client)
      within(:css, '.future-appointments') do
        expect(page).to have_content(formatted_start_time(future))
        expect(page).to_not have_content(formatted_start_time(past))
      end

      within(:css, '.past-appointments') do
        expect(page).to have_content(formatted_start_time(past))
        expect(page).to_not have_content(formatted_start_time(future))
      end
    end
  end
end

def formatted_start_time(appt)
  appt.start_time.strftime('%B %d, %Y, at %I:%M %P')
end
