class Actor < Sequel::Model
  # String :uuid, null: false, limit: 36, index: {unique: true}
  # String :username, limit: 50, index: {unique: true}
end