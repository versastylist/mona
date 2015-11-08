class AppointmentMailer < ApplicationMailer
  default bcc: Proc.new { User.admins.pluck(:email) }

  def cancel_appointment(appt, user_id)
    @appointment = appt.decorate
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: "Appointment Cancellation"
    )
  end

  def appointment_confirmation(appt, user_id)
    @appointment = appt.decorate
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: "Appointment Confirmation"
    )
  end
end
