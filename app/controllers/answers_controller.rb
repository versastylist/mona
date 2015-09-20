class AnswersController < ApplicationController
  def create
    # find
    @answer = fetch_or_create_answer(answer_params)
    # question = Question.find(params[:answer][:question_id])
    # user = User.find(params[:answer][:user_id])
    # question_params = {question: question, user: user}
    # @answer = question ? Answer.where(question_params) : Answer.new(answer_params)
    binding.pry

    if @answer.save
      render json: {status: 200}
    else
      render json: {status: 400}
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

  def fetch_or_create_answer(params)
    question = Question.find(params[:question_id])
    user = User.find(params[:user_id])
    binding.pry
    if question
      answer = Answer.find_by(question: question, user: user)[0].update(params)
    else
      answer = Answer.new(params)
    end

    return answer
  end
end
