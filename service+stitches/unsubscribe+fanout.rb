Feeds::FeedUnsubscriberService.on(:user_has_unsubscribed_from) do |subscriber_id, topic_uuid|
  Feeds::FeedDeleteSubscriberService.delete_subscription(subscriber_id, topic_uuid)
  Fanout::FanoutService.fanout_for_unsubscribe(subscriber_id, topic_uuid)
end