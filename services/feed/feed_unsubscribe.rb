module Feeds
  class FeedUnsubscriberService
    extend Wisper::Publisher
    class << self
      def unsubscribe_from_feed(subscriber_id, topic_uuid)
        publish :user_has_unsubscribed_from, subscriber_id, topic_uuid
      end
    end
  end
end