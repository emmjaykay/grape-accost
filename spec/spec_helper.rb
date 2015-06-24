#APP_ENV = 'test'


require_relative "../server"
require_relative "../config/environment"

require 'rake'
require 'factory_girl'
require 'sequel'
require 'database_cleaner'

DatabaseCleaner.clean_with :truncation

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end


#require 'grape'