require 'rails_helper'

feature 'stylist dashboard' do
  context 'appointments' do
    let(:stylist) { create(:stylist, :with_registration, :receive_email) }
    before { sign_in stylist }

    scenario 'lists future appointments', js: true do
      appointment = create(:appointment, stylist: stylist, start_time: 2.days.from_now)

      visit stylist_path(stylist)
      click_on 'Appointments'

      within(:css, '.future-appointments') do
        expect(page).to have_content(formatted_start_time(appointment))
      end
    end

    scenario 'lists past appointments', js: true do
      future = create(:appointment, stylist: stylist, start_time: 2.days.from_now)
      past = create(:appointment, stylist: stylist, start_time: 2.days.ago)

      visit stylist_path(stylist)
      click_on 'Appointments'

      within(:css, '.future-appointments') do
        expect(page).to have_content(formatted_start_time(future))
        expect(page).to_not have_content(formatted_start_time(past))
      end

      within(:css, '.past-appointments') do
        expect(page).to have_content(formatted_start_time(past))
        expect(page).to_not have_content(formatted_start_time(future))
      end
    end

    scenario 'lists cancelled appointments', js: true do
      cancelled = create(:appointment, stylist: stylist, cancelled: true)

      visit stylist_path(stylist)
      click_on 'Appointments'

      within(:css, '.cancelled-appointments') do
        expect(page).to have_content(formatted_start_time(cancelled))
      end
    end

    scenario 'appointment can be cancelled', js: true do
      appointment = create(:appointment, stylist: stylist, start_time: 4.days.from_now)
      client = appointment.client
      client.settings.update(booking_emails: true)
      create(:time_interval, appointment_id: appointment.id)

      ActionMailer::Base.deliveries = []

      visit stylist_path(stylist)
      click_on 'Appointments'

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

    scenario 'shows number of upcoming appointments', js: true do
      create(:appointment, stylist: stylist, start_time: 2.days.from_now)
      create(:appointment, stylist: stylist, start_time: 2.days.from_now)

      visit stylist_path(stylist)
      click_on 'Appointments'
      expect(page).to have_content('Upcoming appointments: 2')
    end

    scenario 'shows projected revenue of appointments', js: true do
      appt  = create(:appointment, stylist: stylist, start_time: 2.days.from_now)
      appt2 = create(:appointment, stylist: stylist, start_time: 2.days.from_now)
      total = appt.order.subtotal + appt2.order.subtotal

      visit stylist_path(stylist)
      click_on 'Appointments'
      expect(page).to have_content("Projected Revenue: $#{total}.00")
    end

    scenario 'reminds stylist to complete schedules' do
      visit stylist_path(stylist)
      click_on 'Appointments'

      expect(page).to have_content("You still need to create your current schedule")
      expect(page).to have_content("You still need to create your future schedule")
    end

    scenario 'reminds stylist of appointments for current day' do
      Timecop.freeze(Time.local(2015, 11, 7, 10, 0, 0)) do
        create(:appointment, start_time: 1.hour.from_now, stylist: stylist)
        visit stylist_path(stylist)
        click_on 'Appointments'

        expect(page).to have_content("You have an appointment today at: #{1.hour.from_now.strftime('%l:%M %P')}")
      end
    end
  end
end

def formatted_start_time(appt)
  appt.start_time.strftime('%B %d, %Y, at %I:%M %P')
end
