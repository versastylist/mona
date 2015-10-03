class SurveysController < ApplicationController
  def show
    @survey = Survey.find(params[:id])
    @questions = @survey.questions
    @completion = @survey.completions.new
  end
end
