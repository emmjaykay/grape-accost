require_relative 'config/application'  

module Accost
	class API < Grape::API
		version 'v1', using: :accept_version_header
		format :json
		default_format :json

		content_type :json, 'application/json; charset=utf-8'
		content_type :txt, 'text/plain'

    def self.mount_all
      endpoints = [
        ActorsAPI,
        TargetAPI,
        VerbAPI,
        ObjectsAPI,
        CreateAPI,
        FeedAPI,
        SubscribeAPI,
      ]
      endpoints.each { |endpoint| mount endpoint }
    end # mount.all     

    dirs_to_include = [ 
                "/initializers",
                "/endpoints",
                "/lib",
                "/models",
                "/services/activity",
                "/services/feed",
                "/services/fanout",
                "/services/fanout/worker",
                "/service+stitches",
                "/presenters"
              ].map { |x| '/..' + x }
    Accost::Application.load_dirs(dirs_to_include)

    namespace :api do
      mount_all
    end
	end
end
