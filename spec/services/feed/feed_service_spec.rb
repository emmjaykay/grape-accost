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

      let (:stanis_feed_hash) do {
        :feed=>[{:actor_uuid=>"jon", :verb=>"create", :object_uuid=>"comment", :target_uuid=>"target"}], 
        :misc=>{:version=>"v1"}
      }
      end

      it "can do feed" do
        id = Activities::ActivityService.queue(activity)
        feed = Feeds::FeedService.get_feed(get_params)
        
        expect(feed).not_to eq([])
      end # it

      it "can allow subscriber to get a feed" do
        subscriber_id = 'stanis'
        topic_uuid = 'jon'
        Feeds::FeedSubscriberService.subscribe_to_feed(subscriber_id, topic_uuid)
        id = Activities::ActivityService.queue(activity)

        params = {id: subscriber_id}

        stanis_feed = Feeds::FeedService.get_feed(params)

        expect(stanis_feed).not_to eq(nil)
        expect(stanis_feed).to include("feed" => [{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"target"}], "misc" => {"version"=>"v1"})
      end

      it "can show items from before a subscription" do
        subscriber_id = 'stanis'
        topic_uuid = 'jon'
        id = Activities::ActivityService.queue(activity)
        Feeds::FeedSubscriberService.subscribe_to_feed(subscriber_id, topic_uuid)

        params = {id: subscriber_id}

        stanis_feed = Feeds::FeedService.get_feed(params)

        expect(stanis_feed).not_to eq(nil)
        expect(stanis_feed).to include("feed" => [{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"target"}], "misc" => {"version"=>"v1"})
      end

      it "can unsubscribe from a service" do
        subscriber_id = 'stanis'
        topic_uuid = 'jon'
        id = Activities::ActivityService.queue(activity)
        Feeds::FeedSubscriberService.subscribe_to_feed(subscriber_id, topic_uuid)

        params = {id: subscriber_id}

        stanis_feed = Feeds::FeedService.get_feed(params)

        expect(stanis_feed).not_to eq(nil)
        expect(stanis_feed).to include("feed" => [{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"target"}], "misc" => {"version"=>"v1"})
      
        Feeds::FeedUnsubscriberService.unsubscribe_from_feed(subscriber_id, topic_uuid)

        stanis_feed = Feeds::FeedService.get_feed(params)
        
        jon_feed = Feeds::FeedService.get_feed({id: 'jon'})

        expect(stanis_feed).to include("feed"=>[], "misc"=>{"version"=>"v1"})
        expect(jon_feed).to include("feed" => [{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"target"}], "misc" => {"version"=>"v1"})

      end
    end # describe
  end # context
end #describe