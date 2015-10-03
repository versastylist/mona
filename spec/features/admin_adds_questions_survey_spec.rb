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

    scenario 'unsuccessfully'
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

    scenario 'unsuccessfully'
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
