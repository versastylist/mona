class QuestionnairesController < ApplicationController
  def new
    @user = current_user
    questionnaire_id = params[:questionnaire_id]
    @questionnaire = questionnaire_id ? Questionnaire.find(questionnaire_id) : Questionnaire.new

    if @questionnaire && @questionnaire.questions.any? #need to add completed field
      @questions = @questionnaire.questions
      @answers = []

      @questions.length.times do |i|
        ids = {
          question_id: @questions[i].id,
          user_id: @user.id
        }

        answer = fetch_or_intialize_answer(ids)
        @answers << answer
      end
      render :complete_questionnaire
    end
  end

  def create
    @questionnaire = Questionnaire.new
    if @questionnaire.save
      # redirect_to some_path
      # success
    else
      # errors
      render :new
    end
  end

  def index
    @questionnaires = Questionnaire.all #hard-code, re-factor later
  end

  private

  def fetch_or_intialize_answer(ids)
    check_answer = Answer.where(
      question_id: ids[:question_id],
      user_id: ids[:user_id]
    )
    answer = check_answer.any? ? check_answer.first : Answer.new
  end
end
