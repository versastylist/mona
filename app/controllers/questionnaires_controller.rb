class QuestionnairesController < ApplicationController
  def new
    @user = current_user
    preferences_questionnaire = fetch_questionnaire_type('stylist_preferences')

    @questionnaire = Questionnaire.new.fetch_or_initialize(preferences_questionnaire)

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

      @acknowledgement_statement = fetch_questionnaire_type('acknowledgement_statement')
      binding.pry
      render :complete_questionnaire
    end
  end

  private

  def fetch_questionnaire_type(questionnaire_type)
    questionnaire_types = {
      stylist_preferences: 0,
      acknowledgement_statement: 1
    }
    case questionnaire_type
    when 'stylist_preferences'
      return Questionnaire.find_by(
        questionnaire_type: questionnaire_types[:stylist_preferences]
      )
    when 'acknowledgement_statement'
      return Questionnaire.find_by(
        questionnaire_type: questionnaire_types[:acknowledgement_statement]
      )
    end
  end
end
