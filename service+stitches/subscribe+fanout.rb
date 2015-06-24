Feeds::FeedSubscriberService.on(:user_has_subscribed_to) do |subscriber_id, topic_uuid|
  Feeds::FeedCreateSubscriberService.create_subscription(subscriber_id, topic_uuid)
  Fanout::FanoutService.fanout_for_subscriber(subscriber_id, topic_uuid)
end