class AppointmentMailer < ApplicationMailer
  default bcc: Proc.new { User.admins.pluck(:email) }

  def cancel_appointment(appt_id, user_id)
    @appointment = Appointment.find(appt_id).decorate
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: "Appointment Cancellation"
    )
  end

  def appointment_confirmation(appt_id, user_id)
    @appointment = Appointment.find(appt_id).decorate
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: "Appointment Confirmation"
    )
  end
end
