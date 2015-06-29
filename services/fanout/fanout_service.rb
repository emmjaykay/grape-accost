require_relative './worker/feed_create_worker'

module Fanout
  class FanoutService
    class << self

      def fanout_for_subscriber(subscriber_id, subscribee_id)
        Fanout::Workers::FeedSubscriberCreateWorker.perform_async(subscriber_id, subscribee_id)
      end

      def fanout(activity, activity_id)
        Fanout::Workers::FeedCreateWorker.perform_async(activity, activity_id)
      end

    end # class << self
  end # class FanoutService
end # Fanout