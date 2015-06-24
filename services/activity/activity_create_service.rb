module Activities
  class ActivityCreateService
    class << self
      def create!(user_params)
        activity_service = Activity.new
        activity_service.set user_params
        activity_service.save
        activity_service[:id]
      end
    end
  end
end