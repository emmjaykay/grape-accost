#APP_ENV = 'test'


require_relative "../server"
require_relative "../config/environment"

require 'rake'
require 'factory_girl'
require 'sequel'
require 'database_cleaner'
require 'sidekiq/testing'

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction

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
end


#require 'grape'