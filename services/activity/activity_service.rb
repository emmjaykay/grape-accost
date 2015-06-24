module Activities
  class ActivityService
    extend Wisper::Publisher
    class << self
      def queue(user_params)
        publish :activity_created, user_params
      end

      def get_activity(id)
        Activity.where(id: id).all()
      end
    end
  end
end