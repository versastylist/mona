require 'rails_helper'

describe UserDecorator do
  include Rails.application.routes.url_helpers

  describe "#next_registration_path" do
    let(:user) { FactoryGirl.create(:user, role: 'client').decorate }

    it "returns registration path if user hasn't registered" do
      expect(user.next_registration_step).to eq new_client_registration_path
    end
  end
end
