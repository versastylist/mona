require 'rails_helper'

feature 'client dashboard' do
  context 'settings' do
    let(:client) { create(:client, :with_registration) }

    scenario 'visits setting page to update phone', js: true do
      sign_in client

      click_on 'Profile'
      click_on 'Settings'

      fill_in 'Cell Phone', with: '5551113456'
      click_on 'Edit Registration'

      expect(page).to have_content('Updated registration details')
    end

    scenario 'doesnt display if its a different user' do
      visit user_path(client)

      expect(page).to_not have_content('Appointments')
      expect(page).to_not have_content('Settings')
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

    scenario 'lists cancelled appointments' do
      cancelled = create(:appointment, client: client, cancelled: true)

      visit user_path(client)
      within(:css, '.cancelled-appointments') do
        expect(page).to have_content(formatted_start_time(cancelled))
      end
    end

    scenario 'appointment can be cancelled', js: true do
      ActionMailer::Base.deliveries = []
      appointment = create(:appointment, client: client, start_time: 4.days.from_now)
      stylist = appointment.stylist
      create(:time_interval, appointment_id: appointment.id)


      visit user_path(client)
      within(:css, '.future-appointments') do
        click_on 'Cancel Appointment'
      end

      expect(ActionMailer::Base.deliveries.size).to eql(2)

      # the email we just sent should have the proper subject and recipient:
      first_email = ActionMailer::Base.deliveries.first
      expect(first_email).to have_subject('Appointment Cancellation')
      expect(first_email).to deliver_to(client.email)

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email).to have_subject('Appointment Cancellation')
      expect(last_email).to deliver_to(stylist.email)

      expect(page).to have_content('Successfully cancelled appointment')
    end
  end
end

def formatted_start_time(appt)
  appt.start_time.strftime('%B %d, %Y, at %I:%M %P')
end
