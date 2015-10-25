class GuestUser
  def authenticated?
    false
  end

  def completed_registration?
    true
  end

  def next_registration_step
    ''
  end

  def profile_path
    '#'
  end

  def admin?
    false
  end

  def verified_by_management?
    false
  end

  def registration
    true
  end

  def has_seen_stylist?(stylist)
    false
  end

  def has_address_on_file?
    false
  end
end
