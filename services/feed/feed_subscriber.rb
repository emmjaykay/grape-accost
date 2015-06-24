module Feeds
  class FeedSubscriberService
    extend Wisper::Publisher
    class << self
      def subscribe_to_feed(subscriber_id, topic_uuid)
        publish :user_has_subscribed_to, subscriber_id, topic_uuid
      end
    end
  end
end