Activities::ActivityService.on(:activity_created) do |activity|
  activity_id = Activities::ActivityCreateService.create!(activity)
  Feeds::FeedCreateSubscriberService.create_subscription(activity[:actor_uuid], activity[:actor_uuid])
    Fanout::FanoutService.fanout(activity, activity_id)
end