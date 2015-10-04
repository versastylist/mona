require 'rails_helper'

feature 'user answers confirmable question' do
  let(:client) { create(:client) }

  scenario 'successfully' do
    sign_in client

    view_survey_with_question :confirm, title: "Would you use this service with your children?"
    check "Would you use this service with your children?"
    submit_answers

    expect(page).to have_content('Successfully finished survey')
  end
end
