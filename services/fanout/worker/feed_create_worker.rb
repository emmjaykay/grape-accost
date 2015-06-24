require_relative Dir.pwd + '/presenters/feed_presenter'

module Fanout
  module Workers
    class FeedCreateWorker
      include Sidekiq::Worker
      sidekiq_options queue: :feed_creation

      def save_presented_feed(feed,subscriber)
          presented_feed = Presenters::FeedPresenter.new(feed)
          RedisHelpers.set_redis_feed(subscriber, presented_feed.to_json)
      end

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
  end # module
end #module