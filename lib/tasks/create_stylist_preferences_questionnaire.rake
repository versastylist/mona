stylist_preference_questions = [
  {
    client: 'Would you use this service for your children?',
    stylist: 'Would you service children?'
  },
  {
    client: 'Do you have pets?',
    stylist: 'Would you service a Client who owns a pet?'
  },
  {
    client: 'Are you an indoor smoker?',
    stylist: 'Would you service a Client who\'s an indoor smoker?'
  },
  {
    client: 'Is your place carpeted?',
    stylist: 'Are you allergic to carpeted areas?'
  },
  {
    client: 'Do you have any current medical conditions?',
    stylist: 'Would you service a client who has a medical condition?'
  },
  {
    client: 'Do you have any current skin conditions?',
    stylist: 'Would you service a client who has a skin condition?'
  }
]

questionnaire_types = {
  stylist_preferences: '0',
  acknowledgement_statement: '1'
}

namespace :questionnaire do
  desc "Create Questionnaire"
  task :create_stylist_preferences_questionnaire => :environment do
    questionnaire_params = {questionnaire_type: questionnaire_types[:stylist_preferences]}
    questionnaire_exists = Questionnaire.find_by(questionnaire_params).nil?

    if questionnaire_exists
      Questionnaire.create(
        questionnaire_type: questionnaire_types[:stylist_preferences]
      )
    end
  end

  desc "Create Questions"
  task :create_stylist_preferences_questions => :environment do
    questionnaire_params = {questionnaire_type: questionnaire_types[:stylist_preferences]}
    questionnaire = Questionnaire.find_by(questionnaire_params)

    if questionnaire.questions.empty?
      stylist_preference_questions.each do |question|
        question_params = {
          client_question: question[:client],
          stylist_question: question[:stylist],
          questionnaire: questionnaire
        }
        Question.create(question_params)
      end
    end
  end

  task :preferences => [
    :create_stylist_preferences_questionnaire,
    :create_stylist_preferences_questions
  ]
end
