require 'spec_helper'


describe Feeds::FeedService do
  include Rack::Test::Methods
  def app
    Accost::API
  end

  context "Feeds for users" do
    describe "GET /api/feed/" do
      let(:user_params) { {actor_uuid: 'jon', verb:'create', object_uuid:'comment', target_uuid:'a post'} }
      let(:follow_jon) { {topic_uuid: "jon"} }
      let(:jon_feed_item) {{"feed"=>[{"actor_uuid"=>"jon", "verb"=>"create", "object_uuid"=>"comment", "target_uuid"=>"a post"}], "misc"=>{"version"=>"v1"}}}

      it "should get a user's feed" do
        post "/api/create/", user_params
        get  "/api/feed/jon"# user_params.to_json
        expect(JSON.parse(last_response.body)).to include(jon_feed_item)
      end # it

      it "should get a subscribee's feed" do
        post "/api/create", user_params
        post "/api/subscribe/stannis", follow_jon
        get "/api/feed/stannis"
        expect(JSON.parse(last_response.body)).to include(jon_feed_item)
      end
    end #describe
  end # context
end # describe
