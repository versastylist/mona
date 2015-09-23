questions = [
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

namespace :questionnaire do
  desc "Create Questionnaire"
  task :create_questionnaire => :environment do
    Questionnaire.create()
  end

  desc "Create Questions"
  task :create_questions => :environment do
    questionnaire = Questionnaire.first
    questions.each do |question|
      Question.create(
        client_question: question[:client],
        stylist_question: question[:stylist],
        questionnaire: questionnaire
      )
    end
  end

  task :all => [:create_questionnaire, :create_questions]
end
