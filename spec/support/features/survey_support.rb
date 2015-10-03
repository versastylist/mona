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
end
