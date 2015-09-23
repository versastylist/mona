# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :questionnaire do
  desc "Create Questionnaire"
  # task :clicks => :environment do
  #   Click.cleanup!
  # end

  desc "Create Questions"
  # task :logs => :environment do
  #   Log.cleanup!
  # end

  task :all => [:clicks, :logs]
end

questions = [
  {
    client: 'Would you use this service for your children?',
    stylist: 'Would you service a Client who has children?'
  },
  {
    client: 'Do you have pets?',
    stylist: 'Would you service a Client who owns a pet?'
  },
  {
    client: 'Are you an indoor smoker?',
    stylist: 'Would you service a Client whos an indoor smoker?'
  },
  {
    client: 'Is your place carpeted?',
    stylist: 'Are you allergic to carpeted areas?'
  },
  {
    client: 'Do you have any medical conditions?',
    stylist: 'Would you service a client with any medical conditions?'
  },
  {
    client: 'Do you have any skin conditions?',
    stylist: 'Would you service a client with any skin conditions?'
  }
]
