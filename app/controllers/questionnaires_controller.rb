class QuestionnairesController < ApplicationController
  def new
    @user = current_user
    questionnaire_id = Questionnaire.first

    @questionnaire = Questionnaire.new.fetch_or_initialize(questionnaire_id)

    if @questionnaire && @questionnaire.questions.any? #need to add completed field
      @questions = @questionnaire.questions
      @answers = []

      @questions.length.times do |i|
        ids = {
          question_id: @questions[i].id,
          user_id: @user.id
        }

        answer = Answer.new.fetch_or_initialize(ids)
        @answers << answer
      end

      #@questionnaire_complete = Questionnaire.first.questions.count == @user.answers.count
      @questionnaire_complete = Questionnaire.first.completed?(@user)

      render :complete_questionnaire
    end
  end

  def create
    # might need to remove this if we will not let anyone create/modify questionnaires
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
    @questionnaires = Questionnaire.all
  end

  private
end
