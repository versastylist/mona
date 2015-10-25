require 'rails_helper'

feature 'stylist dashboard' do
  context 'services' do

  end

  context 'appointments' do
    let(:stylist) { create(:stylist, :with_registration) }
    before { sign_in stylist }

    scenario 'lists future appointments' do
      appointment = create(:appointment, stylist: stylist, start_time: 2.days.from_now)

      visit stylist_path(stylist)
      within(:css, '.future-appointments') do
        expect(page).to have_content(formatted_start_time(appointment))
      end
    end

    # scenario 'lists past appointments' do
      # future = create(:appointment, client: client, start_time: 2.days.from_now)
      # past = create(:appointment, client: client, start_time: 2.days.ago)

      # visit user_path(client)
      # within(:css, '.future-appointments') do
        # expect(page).to have_content(formatted_start_time(future))
        # expect(page).to_not have_content(formatted_start_time(past))
      # end

      # within(:css, '.past-appointments') do
        # expect(page).to have_content(formatted_start_time(past))
        # expect(page).to_not have_content(formatted_start_time(future))
      # end
    # end

    # scenario 'lists cancelled appointments' do
      # cancelled = create(:appointment, client: client, cancelled: true)

      # visit user_path(client)
      # within(:css, '.cancelled-appointments') do
        # expect(page).to have_content(formatted_start_time(cancelled))
      # end
    # end
  end

  context 'schedule' do

  end

  context 'clients' do

  end

  context 'settings' do

  end
end

def formatted_start_time(appt)
  appt.start_time.strftime('%B %d, %Y, at %I:%M %P')
end
