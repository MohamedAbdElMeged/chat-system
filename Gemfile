source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.6'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Use Redis adapter to run Action Cable in production
gem 'dotenv-rails'
gem 'redis', '~> 4.0'
gem 'redis-namespace'
gem 'securerandom'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
gem 'blueprinter'
gem 'oj'
gem 'rufus-scheduler'
# gem 'rubocop'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
gem 'faraday'
gem 'multi_json'
# gem "nokogiri"
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop', '~> 0.62.0', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-benchmark'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rspec-sidekiq'
  gem 'webmock'
end
gem 'sidekiq', '~> 6.4', '>= 6.4.1'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
