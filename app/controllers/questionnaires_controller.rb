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

      @questionnaire_complete = Questionnaire.first.completed?(@user)

      render :complete_questionnaire
    end
  end

  private
end
