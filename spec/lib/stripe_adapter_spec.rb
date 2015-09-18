require 'rails_helper'

describe StripeAdapter do
  describe "#create_customer" do
    let(:email) { "example@email.com" }
    let(:desc) { "A client on VersaStylist" }
    let(:card) { "4242424242424242" }

    it "creates customer on stripe" do
      stripe = StripeAdapter.new

      resp = stripe.create_customer(card, desc, email)
      expect(resp.status).to eq 200
    end
  end

  describe "#create_card_token" do

  end

  describe "#save_customer" do
    it "saves customers stripe id to their payment info" do

    end
  end
end
