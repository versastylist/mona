module Features
  def view_survey(survey = create(:survey))
    visit survey_path(survey)
  end

  def view_survey_with_question(type, question_attrs = {}, submittable_attrs = {})
    survey = create(:survey)
    submittable = create(:"#{type}_submittable", submittable_attrs)
    question = create(
      :"#{type}_question",
      question_attrs.merge(survey: survey, submittable: submittable)
    )
    view_survey survey
  end

  def submit_answers
    click_on 'Submit Answers'
  end

  def submit_question
    click_on 'Add Question'
  end

  def add_confirm_question(title)
    click_on 'Add Confirmable Question'
    fill_in 'Title', with: title
  end

  def add_multiple_choice_question
    click_on 'Add Multiple Choice Question'
  end
end
