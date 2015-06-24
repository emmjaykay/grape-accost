require 'sequel'
require 'rake'

DB = Sequel.connect(ENV['DATABASE_URL'])
Sequel::Model.db = DB

# if APP_ENV == 'test'
#   DB.tables.each { |table| DB.drop_table table }
#   Rake::Task["db:migrate"].invoke
# end
