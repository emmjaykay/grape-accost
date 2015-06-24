module Feeds
  class FeedService
    extend Wisper::Publisher
    class << self
      def get_feed(user_params)

        subscriber = user_params[:id]

        feed = RedisHelpers.get_redis_feed(subscriber)        
        begin
          JSON.parse(feed)
        rescue
          return nil
        end
      end

      def build_feed(params)

      end
    end
  end
end