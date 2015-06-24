require_relative '../models/actor'

module Accost
  class SubscribeAPI < Grape::API
    resource :subscribe do
      desc "Subscribe to an Activty Stream Actor or topic", {

      }

      route_param :id do
        params do
          requires :topic_uuid
        end

        post do
          user_params = declared(params)
          Feeds::FeedSubscriberService.subscribe_to_feed(params[:id], user_params[:topic_uuid])
          present :success
        end
      end
    end
  end
end