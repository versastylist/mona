source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails', '4.2.4'

# Database/Search
gem 'pg'
gem 'searchkick'    # Elastic Search
gem 'kaminari'      # Pagination
gem 'active_model_serializers'

# Front end assets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'font-awesome-sass', '~> 4.4.0'

# User Authentication
gem 'devise'

# Assorted
gem 'draper'            # ViewModels
gem 'stripe'            # Payment Processing
gem 'carrierwave'       # Image Uploading
gem 'fog'               # S3 Cloud Uploading
gem 'rmagick'           # Image Processing
gem 'faker'             # Seeding Fake Data
gem 'cocoon'            # JQuery Nested Forms
gem 'acts_as_singleton' # Allows Singleton Pattern for AR Objects
gem 'geocoder'          # Location API
gem 'twilio-ruby'       # Text Messaging

# Production
group :production do
  gem 'rails_12factor' # Required for Heroku
end

group :test do
  gem 'poltergeist'      # Javascript Feature Tests
  gem 'database_cleaner' 
  gem 'timecop'
  gem 'email_spec'
end

group :development do
  gem 'annotate'   # Shows Schema in Model files
  gem 'mailcatcher'
end

group :development, :test do
  gem 'railroady'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl'
  gem 'valid_attribute'
  gem 'shoulda-matchers', require: false
  gem 'dotenv-rails'
end
