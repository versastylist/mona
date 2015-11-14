namespace :survey do
  task :registrations  => :environment do
    SurveyBuilder.build_stylist_registration
    SurveyBuilder.build_client_registration
  end
end
