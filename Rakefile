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

Would you use this service for your children?
Do you have pets?
Are you an indoor smoker?
Is your place carpeted?
Do you have any medical or skin condition?

Would you service a Client who has children?
b Would you service a Client who owns a pet?
c Would you service a Client whos an indoor smoker?
d Are you allergic to carpeted areas?

questions = [
  {
    client: 'Would you use this service for your children?',
    stylist: 'Would you service a Client who has children?',
    additional_info: false
  },
  {
    client: 'Do you have pets?',
    stylist: 'Would you service a Client who owns a pet?',
    additional_info: false
  },
  {
    client: 'Are you an indoor smoker?',
    stylist: 'Would you service a Client whos an indoor smoker?',
    additional_info: false
  },
  {
    client: 'Is your place carpeted?',
    stylist: 'Are you allergic to carpeted areas?',
    additional_info: false
  },
  {
    client: 'Do you have any medical or skin conditions?',
    stylist: 'Would you service a client with any medical or skin conditions?',
    additional_info: true
  },
  {
    client: 'blah blah',
    stylist: 'blah blah',
    additional_info: true||false
  }
]
