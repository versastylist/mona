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
end
