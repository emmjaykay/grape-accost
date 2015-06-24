FactoryGirl.define do
  factory :activity do
    to_create do |aktivity|
      user_params = {
        actor_uuid: 'jon',
        verb: 'create',
        object_uuid: 'comment',
        target_uuid: 'target'
      }
      #Activities::ActivityCreateService.create!(user_params)
      #user_params.instance_variable_set :@activity, aktivity
      user_params.save
    end
  end
end