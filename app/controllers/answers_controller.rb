class AnswersController < ApplicationController
  def create
    current_user
    @answer = Answer.new.update_or_initialize(answer_params)
    questionnaire_type = @answer.question.questionnaire.questionnaire_type
    questionnaire_complete = Questionnaire.find_by(questionnaire_type: questionnaire_type).completed?(current_user)

    respond_to do |format|
      if current_user && @answer.save
        status = 200
      else
        status = 400
      end

      # format.html { render :complete_questionnaire }

      format.html { redirect_to new_user_questionnaire_path }
      format.json {
        render json: {
          status: status, questionnaireComplete: questionnaire_complete
        }
      }
    end
  end

  def update
    current_user
    @answer = Answer.new.update_or_initialize(answer_params)
    questionnaire_type = @answer.question.questionnaire.questionnaire_type
    questionnaire_complete = Questionnaire.find_by(questionnaire_type: questionnaire_type).completed?(current_user)

    respond_to do |format|
      if current_user && @answer.save
        status = 200
      else
        status = 400
      end

      # format.html { render :complete_questionnaire }

      format.html { redirect_to new_user_questionnaire_path }
      format.json {
        render json: {
          status: status, questionnaireComplete: questionnaire_complete
        }
      }
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
