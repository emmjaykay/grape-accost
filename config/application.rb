require 'byebug'
require 'grape'
require 'sequel'
require 'wisper'
require 'sidekiq'
require 'grape-entity'

APP_ENV = ENV['APP_ENV'] if ENV['APP_ENV'] != nil 
APP_ENV = 'development' if ENV['APP_ENV'] == nil

require 'dotenv'
env = APP_ENV

%W(env/.env.global env/.env.#{env}).map { |f| "#{Dir.pwd}/#{f}" }.each { |x|
  Dotenv.load x
}

module Accost
  class Application
    class << self
      def load_dirs(dirs_to_include)
        dirs_to_include.each { |dir|
          path_to_dir = File.dirname(__FILE__) + dir + "/*.rb"
          Dir[path_to_dir].each {|file| require file }  
        }        
      end # load_dirs
                                                                                                                                                     


      def initialize!

      end
    end
  end
end