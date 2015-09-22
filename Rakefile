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
    client: 'blah blah',
    stylist: 'blah blah'
  },
  {
    client: 'blah blah',
    stylist: 'blah blah'
  },
  {
    client: 'blah blah',
    stylist: 'blah blah'
  },
  {
    client: 'blah blah',
    stylist: 'blah blah'
  },
  {
    client: 'blah blah',
    stylist: 'blah blah'
  },
  {
    client: 'blah blah',
    stylist: 'blah blah'
  }
]
