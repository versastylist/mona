class CompletionsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    completion = @survey.completions.new(completion_params)
    completion.user = current_user
    completion.save!

    if @survey.client_registration?
      redirect_to menu_filters_path,
        success: "Successfully finished survey"
    elsif @survey.stylist_registration?
      redirect_to stylist_path(current_user),
        success: "Successfully finished survey"
    else
      redirect_to root_path,
        success: "Successfully finished survey"
    end
  end

  private

  def completion_params
    params.require(:completion).permit(answers_attributes: [:text])
  end
end
