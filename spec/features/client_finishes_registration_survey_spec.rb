require 'rails_helper'

feature 'client finishes registration survey' do
  scenario 'successfully' do
    client = create(:client)
    sign_in client

    visit registration_survey_path
    submit_answers
    expect(page).to have_content('Successfully finished survey')
  end
end
