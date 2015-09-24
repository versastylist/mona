class AnswersController < ApplicationController
  def create
    # find
    current_user
    @answer = Answer.new.update_or_initialize(answer_params)

    if current_user && @answer.save
      questionnaire_complete = Questionnaire.first.completed?(current_user)

      render json: {status: 200, questionnaireComplete: questionnaire_complete}
    else
      render json: {status: 400, questionnaireComplete: questionnaire_complete}
    end
  end

  private

  def answer_params
    params.require(:answer).permit(
      :user_type,
      :answer,
      :user_id,
      :question_id
    )
  end
end
