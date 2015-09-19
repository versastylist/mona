source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails', '4.2.4'

# Database/Search
gem 'pg'

# Front end assets
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'

# User Authentication
gem 'devise'

# Assorted
gem 'draper'        # ViewModels
gem 'stripe'        # Payment Processing
gem 'carrierwave'   # Image Uploading
gem 'fog'           # S3 Cloud Uploading
gem 'rmagick'       # Image Processing
gem 'searchkick'    # Elastic Search
gem 'faker'         # Seeding Fake Data

# Production
group :production do
  gem 'rails_12factor' # Required for Heroku
end

group :test do
  gem 'poltergeist'      # Javascript Feature Tests
  gem 'database_cleaner' 
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'factory_girl'
  gem 'valid_attribute'
  gem 'shoulda-matchers', require: false
  gem 'dotenv-rails'
end

group :development do
  gem 'annotate'
end

