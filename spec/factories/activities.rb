FactoryGirl.define do
  factory :activity do
    to_create do |aktivity|
      user_params = {
        actor_uuid: 'jon',
        verb: 'create',
        object_uuid: 'comment',
        target_uuid: 'target'
      }

      user_params.save
    end
  end
end