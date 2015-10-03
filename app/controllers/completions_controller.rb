class CompletionsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    completion = @survey.completions.new(completion_params)
    completion.user = current_user
    completion.save!
    redirect_to root_path, success: "Successfully finished survey"
  end

  private

  def completion_params
    params.require(:completion).permit(:answers_attributes)
  end
end
