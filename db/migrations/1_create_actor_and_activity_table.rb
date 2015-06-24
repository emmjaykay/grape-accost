Sequel.migration do
  change do
    create_table :actor do
      primary_key :id
      String :uuid, null: false, limit: 36, index: {unique: true}
      String :username, limit: 50, index: {unique: true}
    end

    create_table :activity do
      primary_key :id
      String :actor_uuid, null: false, limit: 36
      String :verb, null: false, limit: 255
      String :object_uuid, null: false, limit: 36
      String :target_uuid, null: true, limit: 36
    end
  end
end
