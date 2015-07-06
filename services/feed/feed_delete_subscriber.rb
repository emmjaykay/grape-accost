module Feeds
  class FeedDeleteSubscriberService
    extend Wisper::Publisher


    class << self


      def delete_subscription(subscriber_id, topic_uuid)

        subscribers = Subscription.where(subscriber_uuid: subscriber_id, topic_uuid: topic_uuid).all()
        subscribers.each do |subscriber|
          subscriber.delete
        end

      end

    end # class self
  end # class FeedCreateSubscriberService
end # module Feeds