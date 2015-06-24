require 'byebug'

require 'sequel'
require_relative 'config/environment'
APP_ENV = ENV['APP_ENV'] unless defined? APP_ENV 

Sequel.extension :migration

MIGRATIONS = './db/migrations'
db = Sequel.connect(ENV['DATABASE_URL'])

namespace :db do
  task :migrate do |target|
    Sequel::Migrator.run(db, MIGRATIONS)
  end  
  task :reset do |target|
    DB.tables.each { |table| DB.drop_table table }
    Sequel::Migrator.run(db, MIGRATIONS)
  end
end
