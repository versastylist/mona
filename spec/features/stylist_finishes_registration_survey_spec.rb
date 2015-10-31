require 'rails_helper'

feature 'stylist finishes registration survey' do
  scenario 'successfully' do
    stylist = create(:stylist)
    sign_in stylist

    visit registration_survey_path
    submit_answers
    expect(page).to have_content('Successfully finished survey')
    expect(page).to have_content("#{stylist.username}'s profile")
  end
end
