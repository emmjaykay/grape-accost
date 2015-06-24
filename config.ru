RACK_APP = self

require 'rack'

require_relative 'config/environment'

require_relative 'server'

run Accost::API