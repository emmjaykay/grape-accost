Sequel.migration do
  change do
    create_table :activity_feed do
      primary_key :id
      String :actor_uuid, null: false, limit: 36
      Integer :activity_primary_id
      unique [:actor_uuid, :activity_primary_id]
    end
  end
end
