require 'spec_helper'


describe Accost::CreateAPI do
  # https://github.com/dblock/grape/blob/master/README.md#writing-tests
  include Rack::Test::Methods
  def app
    Accost::API
  end

  context "Create an activity" do
    describe "POST /api/create/" do
      let(:user_params) { {actor_uuid: 'jon', verb:'create', object_uuid:'comment', target_uuid:'a post'} }
      let(:follow_jon) { {topic_uuid: "jon"} }
      let(:jon_feed_item) {{"feed"=>[{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"a post"}], "misc"=>{"version"=>"v1"}}}

      it "should get a user's feed" do
        expect {
          post "/api/create/", user_params
        }.to change { Activity.count }.by(1)
      end # it

      it "should get a subscribee's feed" do
        expect {
          post "/api/subscribe/stannis", follow_jon
          post "/api/create/", user_params
        }.to change { ActivityFeed.count }.by(2) # 1 for each subscriber, jon and stannis both

      end # it
    end # describe
  end # context
end # describe
