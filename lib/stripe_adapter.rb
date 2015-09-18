class StripeAdapter
  def create_card_token

  end

  def create_customer(card, desc, email)
    binding.pry
    resp = Stripe::Customer.create(
      card: card,
      description: desc,
      email: email
    )
    binding.pry
    resp
  end

  def save_customer_id(payment_info, customer_id)

  end
end
