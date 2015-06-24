module Accost
  class FeedAPI < Grape::API
    resource :feed do

      desc "Get a feed for a user"
      # params do
      #   requires :id, type: String, desc: "user whose feed is to be retreived"
      # end
      route_param :id do

        get do

          feed = Feeds::FeedService.get_feed(params)
          feed

        end # get
      end # route_param

    end # resource
  end # class
end # module