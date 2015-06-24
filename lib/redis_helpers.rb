module RedisHelpers
  class << self
    FEED_KEYSPACE = ":FEED"

    def get_redis_feed(feed_uuid)
      key = redis_feed_key(feed_uuid)
      get_from_redis key
    end

    def set_redis_feed(feed_uuid, feed)
      key = redis_feed_key(feed_uuid)
      set_to_redis(key, feed)
    end

    def redis_feed_key(feed_uuid)
      key = FEED_KEYSPACE + ":" + feed_uuid
      key
    end

    def get_from_redis(key)
      REDIS.get(key)
    end

    def set_to_redis(key, value)
      REDIS.set(key, value)
    end
  end
end