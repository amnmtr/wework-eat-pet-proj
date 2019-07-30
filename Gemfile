# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

# After installing fill in gem versions
# You will probably want to lock it to a minor version
# ex. gem 'rspec-rails', '3.5'
#
# Optional, but often useful, gems are commented out

# gem 'awesome_print'
gem 'bunny'
gem 'deliveries_manager', path: 'lib/deliveries_manager'
gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master' # Error while generating data
gem 'le'
gem 'newrelic_rpm'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'rake'
gem 'sidekiq'
gem 'active_model_serializers'
gem "activemodel", require: "active_model"
gem 'faraday'
gem 'hashie'
gem "json-schema"
gem 'ruby-debug-ide'
gem 'debase'
gem 'sigdump', require: 'sigdump/setup'


group :development do
  gem 'annotate'
  gem 'rubocop-airbnb', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'brakeman'
  gem 'byebug'
  gem 'dotenv-rails'
  gem 'dotenv-sync'
  #gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
end
