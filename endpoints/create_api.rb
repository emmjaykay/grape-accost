require_relative '../models/actor'

module Accost
  class CreateAPI < Grape::API
    resource :create do
      desc "Create an Activty Stream Object", {

      }

      params do
        requires :actor_uuid
        requires :verb
        requires :object_uuid
        requires :target_uuid
      end

      post do
        user_params = declared(params)
        Activities::ActivityService.queue(user_params)
        present :success
      end
    end
  end
end