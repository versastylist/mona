namespace :survey do
  task :registrations  => :environment do
    SurveyBuilder.build_client_survey
  end
end
