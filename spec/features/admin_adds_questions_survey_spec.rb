require 'rails_helper'

feature 'admin can add questions to survey' do
  context 'confirmable question type' do
    let(:admin) { create(:admin)  }
    let(:survey) { create(:survey) }

    scenario 'successfully' do
      sign_in admin

      visit admin_survey_path(survey)
      click_on 'Add Confirmable Question'

      fill_in 'Title', with: 'Will you service children?'
      click_on 'Add Question'

      expect(page).to have_content('Successfully added question')
    end

    scenario 'unsuccessfully'
  end
end
