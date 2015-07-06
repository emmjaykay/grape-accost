require_relative Dir.pwd + '/presenters/feed_presenter'

module Fanout
  module Workers
    class FeedWorker
      include Sidekiq::Worker
      sidekiq_options queue: :feed_creation

      def save_presented_feed(feed,subscriber)
          presented_feed = Presenters::FeedPresenter.new(feed)
          RedisHelpers.set_redis_feed(subscriber, presented_feed.to_json)
      end
    end


    class FeedCreateWorker < FeedWorker

      def perform(activity, activity_id)

        subscribers = Subscription.where(topic_uuid: activity['actor_uuid'])
        subscribers.each do |subscriber|
          feed_activity_item = ActivityFeed.new(actor_uuid: subscriber.subscriber_uuid, activity_primary_id: activity_id)
          begin
            feed_activity_item.save
          rescue
          end #begin, rescue
  
          feed = ActivityFeed.where(actor_uuid: subscriber.subscriber_uuid).all()
          save_presented_feed(feed, subscriber.subscriber_uuid)
        end # for each subscriber

        feed = ActivityFeed.where(actor_uuid: activity['actor_uuid']).all()
        save_presented_feed(feed, activity['actor_uuid'])

      end # def perform
    end # class 


    class FeedSubscriberCreateWorker < FeedWorker

      def perform(subscriber_id, subscribee_id)

        items_from_activity_feed = ActivityFeed.where(actor_uuid: subscribee_id)
        items_from_activity_feed.each do |feed_item|

          begin
            if ActivityFeed.where(actor_uuid: subscriber_id, activity_primary_id: feed_item[:activity_primary_id]).all() == []
              # If this is not already in the user's activity feed
              feed_activity_item = ActivityFeed.new(actor_uuid: subscriber_id, activity_primary_id: feed_item[:activity_primary_id])
              feed_activity_item.save

            end
          rescue
            # log an error ?
          end

          feed = ActivityFeed.where(actor_uuid: subscriber_id).all()
          save_presented_feed(feed, subscriber_id)

        end # for each item from activity feed
      end # perform
    end # class

    class FeedUnsubscribeWorker < FeedWorker
      def perform(subscriber_id, subscribee_id)
        items_from_activity_feed = ActivityFeed.where(actor_uuid: subscribee_id)
        items_from_activity_feed.each do |feed_item|
          if ActivityFeed.where(actor_uuid: subscriber_id, activity_primary_id: feed_item[:activity_primary_id]).all() != []
            feed_activity_item = ActivityFeed.where(actor_uuid: subscriber_id, activity_primary_id: feed_item[:activity_primary_id])
            feed_activity_item.delete
          end
        end

        feed = ActivityFeed.where(actor_uuid: subscriber_id).all()
        save_presented_feed(feed, subscriber_id)

      end # perform
    end # class

  end # module
end #module