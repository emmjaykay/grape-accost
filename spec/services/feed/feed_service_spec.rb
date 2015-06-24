require 'spec_helper'

describe Feeds::FeedService do
  context "Feeds for users" do
    describe "get a feed" do
      let(:activity) do {
          actor_uuid: 'jon',
          verb: 'create',
          object_uuid: 'comment',
          target_uuid: 'target'
        }
      end

      let(:activity_asdf) do {
          actor_uuid: 'asdf',
          verb: 'delete',
          object_uuid: 'post',
          target_uuid: nil
        }
      end

      let(:get_params) do {
          id: 'jon'
        }
      end
      let (:get_params_asdf) do {
        id: 'asdf'
      }
      end

      it "can do feed" do
        id = Activities::ActivityService.queue(activity)
        feed = Feeds::FeedService.get_feed(get_params)
        
        expect(feed).not_to eq([])
      end # it

      it "can allow subscriber to get a feed" do
        id = Activities::ActivityService.queue(activity)
        subscriber_id = 'stanis'
        topic_uuid = 'jon'
        params = {id: subscriber_id}
        Feeds::FeedSubscriberService.subscribe_to_feed(subscriber_id, topic_uuid)
        byebug

        stanis_feed = Feeds::FeedService.get_feed(params)

        expect(stanis_feed).not_to eq([])
      end

    end # describe
  end # context
end #describe