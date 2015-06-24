require 'grape-entity'

module Feeds
  class FeedPresenterService < Grape::Entity
    class << self
      def get_presented_feed(feed)
        represent([feed], with: Presenters::FeedPresenter)
      end
    end
  end
end