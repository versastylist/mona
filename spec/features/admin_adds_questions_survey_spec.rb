require 'rails_helper'

feature 'admin can add questions to survey' do
  let(:admin) { create(:admin)  }
  let(:survey) { create(:survey) }

  context 'confirmable question type' do
    scenario 'successfully' do
      sign_in admin

      visit admin_survey_path(survey)
      add_confirm_question('Will you service children?')
      submit_question

      expect(page).to have_content('Successfully added question')
    end

    scenario 'unsuccessfully' do
      sign_in admin

      visit admin_survey_path(survey)
      click_on 'Add Confirmable Question'
      click_on 'Add Question'

      expect(page).to have_content('1 error')
    end
  end

  context 'multiple choice question type' do
    scenario 'successfully' do
      sign_in admin

      visit admin_survey_path(survey)
      add_multiple_choice_question
      fill_in 'Title', with: 'How did you hear about us?'
      add_options_with_text 'Internet', 'Friend'
      submit_question

      expect(page).to have_content('Successfully added question')
    end

    scenario 'unsuccessfully' do
      sign_in admin

      visit admin_survey_path(survey)
      click_on 'Add Multiple Choice Question'
      click_on 'Add Question'

      expect(page).to have_content("Title can't be blank")
    end
  end

   def add_options_with_text(*texts)
    texts.each_with_index do |text, index|
      fill_in(
        "question_submittable_attributes_options_attributes_#{index}_text",
        with: text
      )
    end
  end
end
