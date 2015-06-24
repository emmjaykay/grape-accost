class Activity < Sequel::Model(:activity)
  plugin :json_serializer
  # String :actor_uuid, null: false, limit: 36
  # String :verb, null: false, limit: 255
  # String :object_uuid, null: false, limit: 36
  # String :target_uuid, null: false, limit: 36
end