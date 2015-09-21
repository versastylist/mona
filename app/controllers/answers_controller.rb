class AnswersController < ApplicationController
  def create
    # find
    @user = current_user
    @answer = fetch_or_initialize_answer(answer_params)

    if @answer.save
      if @user
        questionnaire_complete = Questionnaire.first.questions.count == @user.answers.count
      end
      render json: {status: 200, questionnaireComplete: questionnaire_complete}
    else
      render json: {status: 400, questionnaireComplete: questionnaire_complete}
    end
  end

  def index
    # @questionnaires = Questionnaire.all #hard-code, re-factor later
  end

  private

  def answer_params
    params.require(:answer).permit(
      :user_type,
      :answer,
      :additional_info,
      :user_id,
      :question_id
    )
  end

  def fetch_or_initialize_answer(params)
    question = Question.find(params[:question_id])
    user = User.find(params[:user_id])
    answer = Answer.where(question: question, user: user)

    if question && answer.any?
      answer = Answer.where(question: question, user: user)[0]
      answer.update_attributes(params)
    else
      answer = Answer.new(params)
    end

    return answer
  end
end
