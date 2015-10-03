class RegistrationSurveysController < ApplicationController
  def show
    @survey = Survey.find_or_create_registration_survey(current_user)
    @questions = @survey.questions
    @completion = @survey.completions.new
  end
end
