Sequel.migration do
  change do
    create_table :subscription do
      primary_key :id
      String :subscriber_uuid, null: false, limit: 36
      String :topic_uuid, null: false, limit: 36
      DateTime :subscribed_at
    end
  end
end
