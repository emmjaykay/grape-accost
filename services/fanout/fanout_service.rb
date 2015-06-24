require_relative './worker/feed_create_worker'

module Fanout
  class FanoutService
    class << self
      def fanout_for_subscriber(subscriber_id, topic_uuid)
        items_from_activity_feed = ActivityFeed.where(actor_uuid: topic_uuid)
        items_from_activity_feed.each do |feed_item|
          begin
            if ActivityFeed.where(actor_uuid: topic_uuid, activity_primary_id: feed_item[:activity_primary_id]).all() == []
              # If this is not already in the user's activity feed
              feed_activity_item = ActivityFeed.new(actor_uuid: subscriber_id, activity_primary_id: feed_item[:activity_primary_id])
              feed_activity_item.save
            end
          rescue
            # log an error ?
          end

        end
      end

      def fanout(activity, activity_id)
        Fanout::Workers::FeedCreateWorker.perform_async(activity, activity_id)
      end

    end # class << self
  end # class FanoutService
end # Fanout