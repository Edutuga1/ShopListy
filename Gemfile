source "https://rubygems.org"

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"  # Ensure image_processing is enabled for image variants

# Use Bootstrap for UI [https://getbootstrap.com/]
gem "bootstrap", "~> 5.2"

# Authentication [https://github.com/heartcombo/devise]
gem "devise"

# Automatically add vendor prefixes to CSS [https://github.com/ai/autoprefixer-rails]
gem "autoprefixer-rails"

# Font Awesome for icons [https://github.com/FortAwesome/font-awesome-sass]
gem "font-awesome-sass", "~> 6.1"

# Simple form builder [https://github.com/heartcombo/simple_form]
gem "simple_form", github: "heartcombo/simple_form"

# SASS for CSS [https://github.com/sass/sassc-rails]
gem "sassc-rails"

# Google OAuth2
gem 'omniauth-google-oauth2'

# Move dotenv-rails outside the :development group
gem 'dotenv-rails'

group :development do
  # Rails console in the browser [https://github.com/rails/web-console]
  gem "web-console"

  # Error highlighting in the console [https://github.com/ruby/error_highlight]
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  # Integration testing [https://github.com/teamcapybara/capybara]
  gem "capybara"

  # Web browser control for testing [https://github.com/SeleniumHQ/selenium]
  gem "selenium-webdriver"
end

gem "dockerfile-rails", ">= 1.7", :group => :development

gem "redis", "~> 5.4"

gem "aws-sdk-s3", "~> 1.182", :require => false

gem 'nodejs'
