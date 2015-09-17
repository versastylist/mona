class QuestionsController < ApplicationController
  def new
    # @user = current_user
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @question = Question.new
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @question = Question.create(question_params)

    if @question.save
      redirect_to questionnaires_path
      # success
    else
      # errors
      flash[:errors] = @question.errors.full_messages
      render :new
    end
  end

  def index
    @questions = Questionnaire.find(params[:questionnaire_id])
      .questions
  end

  private

  def question_params
    params.require(:question).permit(
      :client_question,
      :stylist_question,
      :additional_info,
      :questionnaire_id
    )
  end
end
