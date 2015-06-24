module Feeds
  class FeedCreateSubscriberService
    extend Wisper::Publisher


    class << self


      def create_subscription(subscriber_id, topic_uuid)

        if Subscription.where(subscriber_uuid: subscriber_id, topic_uuid: topic_uuid).all() == []
          subscription = Subscription.new subscriber_uuid: subscriber_id , topic_uuid: topic_uuid, subscribed_at: Time.now.utc
          subscription.save
        end

      end

    end # class self
  end # class FeedCreateSubscriberService
end # module Feeds