module SettingsHelpers
  extend ActiveSupport::Concern

  included do
    after_create :make_settings

    delegate :premium_membership,
      :verified,
      :enable_booking,
      :multiple_services,
      :booking_texts,
      :booking_emails,
      to: :settings
  end

  def premium_member?
    premium_membership
  end

  def verified_by_management?
    verified
  end

  def active?
    enable_booking
  end

  def allow_multiple_services?
    multiple_services
  end

  def send_booking_text?
    booking_texts
  end

  def send_booking_email?
    booking_emails
  end

  def enable_booking!
    self.settings.update(enable_booking: true)
  end

  def verify!
    self.settings.update(verified: true)
  end

  def make_premium!
    self.settings.update(premium_membership: true)
  end

  private

  def make_settings
    setting = self.build_settings
    setting.save!
  end
end
