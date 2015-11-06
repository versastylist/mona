# Depending on the environment make sure all emails get sent to joel/chris for
# QAing instead of getting sent to real users.
if Rails.env.development? || ENV['REDIRECT_MAILERS']
  class OverrideMailRecipient
    def self.delivering_email(mail)
      mail.to = ENV['REDIRECT_MAILERS'] || 'spencercdixon+trash@gmail.com'
    end
  end
  ActionMailer::Base.register_interceptor(OverrideMailRecipient)
end
