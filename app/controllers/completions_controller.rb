class CompletionsController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    completion = @survey.completions.new(completion_params)
    completion.user = current_user

    if completion.save
      flash[:success] = "Successfully finished survey"

      if @survey.client_registration?
        redirect_to menu_filters_path
      elsif @survey.stylist_registration?
        redirect_to stylist_path(current_user)
      else
        redirect_to root_path
      end
    else
      flash[:warning] = "Something went wrong trying to save your survey"
      redirect_to root_path
    end
  end

  def update
    @completion = Completion.find(params[:id])
    @completion.update_completion(completion_params[:answers_attributes])
    redirect_to :back
  end

  private

  def completion_params
    params.require(:completion).permit(answers_attributes: [:text, :id])
  end
end
