module Presenters
  class FeedPresenter < Grape::Entity
    expose :feed

    expose :misc
    private
    def misc
      {version: 'v1'}
    end
    
    def feed
      object.map do |activity_item|
        activity = Activities::ActivityService.get_activity(activity_item[:activity_primary_id]).first
        activity.values.delete(:id)
        activity.as_json()
      end
    end
  end
end
