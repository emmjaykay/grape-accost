#APP_ENV = 'test'


require_relative "../server"
require_relative "../config/environment"

require 'rake'
require 'factory_girl'
require 'sequel'
require 'database_cleaner'
require 'sidekiq/testing'
require 'rack/test'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

Dir[File.dirname(__FILE__) + ("/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.around(:each) do |example|
    # https://github.com/mperham/sidekiq/wiki/Testing
    Sidekiq::Testing.inline!(&example)
  end 

  config.after(:each) do
    REDIS.flushdb
  end

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  # https://www.relishapp.com/rspec/rspec-core/v/2-4/docs/filtering/run-all-when-everything-filtered
  # https://www.relishapp.com/rspec/rspec-core/v/2-6/docs/filtering/inclusion-filters
end


#require 'grape'