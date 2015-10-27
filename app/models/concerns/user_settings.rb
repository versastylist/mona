module UserSettings
  extend ActiveSupport::Concern

  included do
    serialize :settings, HashSerializer
    store_accessor :settings,
      :premium_membership,
      :verified_by_management
  end

  def premium_member?
    premium_membership || false
  end

  def verified_by_management?
    verified_by_management || false
  end
end
