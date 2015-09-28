class QuestionnairesController < ApplicationController
  def new
    @user = current_user
    preferences_questionnaire = Questionnaire.new.fetch_questionnaire_type('stylist_preferences')

    @questionnaire = preferences_questionnaire
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

      @acknowledgement_statement = Questionnaire.new.fetch_questionnaire_type('acknowledgement_statement')
      if @questionnaire.completed?(current_user)
        @acknowledgement_questions = @acknowledgement_statement.questions
        @acknowledgement_answers = []

        @acknowledgement_questions.length.times do |i|
          ids = {
            question_id: @acknowledgement_statement.questions[i].id,
            user_id: @user.id
          }

          answer = Answer.new.fetch_or_initialize(ids)
          @acknowledgement_answers << answer
        end
      end

      render :complete_questionnaire
    end
  end

  private
end
