client_questions = [
  'I have a water faucet near the area you want to be serviced',
  'I have a working electrical outlets',
  'I have a chair or a stool'
]

questionnaire_types = {
  stylist_preferences: '0',
  acknowledgement_statement: '1'
}

namespace :questionnaire do
  desc "Create Questionnaire"
  task :create_acknowledgement_questionnaire => :environment do
    questionnaire_params = {questionnaire_type: questionnaire_types[:acknowledgement_statement]}
    questionnaire_exists = Questionnaire.find_by(questionnaire_params).nil?
    if questionnaire_exists
      Questionnaire.create(
        questionnaire_type: questionnaire_types[:acknowledgement_statement]
      )
    end
  end

  desc "Create Questions"
  task :create_acknowledgement_questionnaire => :environment do
    questionnaire_params = {questionnaire_type: questionnaire_types[:acknowledgement_statement]}
    questionnaire = Questionnaire.find_by(questionnaire_params)

    if questionnaire.questions.empty?
      client_questions.each do |question|
        Question.create(
          client_question: question,
          stylist_question: question,
          questionnaire: questionnaire
        )
      end
    end
  end

  task :acknowledgement => [
    :create_acknowledgement_questionnaire,
    :create_stylist_preferences_questions
  ]
end
